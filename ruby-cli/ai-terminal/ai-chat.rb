# deepseek_chat.rb
require 'dotenv/load'
require 'net/http'
require 'json'
require 'uri'



# .env file check
unless ENV['OPENROUTER_API_KEY']
    puts "🔐 No API key found. Please enter your OpenRouter API key:"
    print "> "
    user_key = gets.strip
  
    File.write('.env', "OPENROUTER_API_KEY=#{user_key}\n")
    puts "✅ Saved to .env file. Please restart the script."
    exit
  end

API_KEY = ENV['OPENROUTER_API_KEY']
MODEL = 'google/gemini-2.0-flash-exp:free'
uri = URI('https://openrouter.ai/api/v1/chat/completions')
headers = {
  'Authorization' => "Bearer #{API_KEY}",
  'Content-Type' => 'application/json'
}


# Chat Application
puts "💬 Gemini 2.0 Flash CLI Chat (via OpenRouter)"
puts "Type 'exit' to quit."

messages = [
    { role: "system", content: "You are a helpful assistant. Always respond in the same language the user uses." }
  ]
loop do
  print "You > "
  input = gets.strip
  break if input.downcase == 'exit'

  messages << { role: "user", content: input }

  body = {
    model: MODEL,
    messages: messages,
    stream: false
  }.to_json

  res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    http.post(uri.path, body, headers)
  end

  if res.is_a?(Net::HTTPSuccess)
    json = JSON.parse(res.body)
    response = json.dig("choices", 0, "message", "content")
    puts "AI Chat bot: > #{response.strip}"
    messages << { role: "assistant", content: response }
  else
    puts "Error: #{res.code} - #{res.message}"
    puts res.body
  end
end
