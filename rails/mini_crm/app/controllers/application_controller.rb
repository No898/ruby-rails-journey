class ApplicationController < ActionController::Base
  before_action :set_chat_variables

  allow_browser versions: :modern

  private

  def set_chat_variables
    @message = session.delete(:message)
    @answer = session.delete(:answer)
  end
end
