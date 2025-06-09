# app/controllers/chat_controller.rb
require 'open3'
require 'timeout'

class ChatController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = params[:message]
    
    begin
      client = OpenRouterClient.new
      response = client.chat(@message)

      if response.success?
        generated_code = response.dig("choices", 0, "message", "content")
        # Wrap the code to scope it to current user's data
        scoped_code = <<-RUBY
          User.current = User.find(#{current_user.id})
          #{generated_code}
        RUBY
        @answer = safe_eval(scoped_code)
      else
        error_message = response.parsed_response || "Unknown AI communication error."
        @answer = "Error: #{error_message}"
      end
    rescue => e
      @answer = "An exception occurred: #{e.message}"
    ensure
      # Reset User.current to avoid any potential leaks
      User.current = nil
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("chat_messages", partial: "chat/messages"),
          turbo_stream.update("chat_form", partial: "chat/form")
        ]
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private

  def safe_eval(code)
    # 1. Static analysis for dangerous keywords to prevent write operations.
    dangerous_keywords = [
      '.create', '.create!', '.new', '.save', '.update', '.update!',
      '.destroy', '.delete', '.destroy_all', '.delete_all', 'User.first.update'
    ]
    if dangerous_keywords.any? { |keyword| code.include?(keyword) }
      return "I'm sorry, but I cannot perform operations that modify data (like deleting or updating). I can only search for information."
    end

    # 2. Wrap the code in a transaction that is always rolled back.
    # This provides a second layer of defense against unauthorized data modification.
    wrapped_code = <<-RUBY
      ActiveRecord::Base.transaction(requires_new: true) do
        begin
          #{code}
        ensure
          User.current = nil
        end
        raise ActiveRecord::Rollback
      end
    RUBY
    
    temp_script = Tempfile.new('ai_script')
    temp_script.write(wrapped_code)
    temp_script.close

    stdout = ""
    stderr = ""
    status = nil

    begin
      # 3. Execute the code in a separate process with a 10-second timeout.
      Timeout.timeout(10) do
        stdout, stderr, status = Open3.capture3("bin/rails", "runner", temp_script.path)
      end
    rescue Timeout::Error
      return "Error: The generated code took too long to execute and was terminated."
    end

    if status&.success?
      stdout.strip
    else
      "Error executing code: #{stderr.strip}"
    end
  ensure
    temp_script.unlink if temp_script
  end
end 