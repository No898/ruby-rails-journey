require 'httparty'

class OpenRouterClient
  include HTTParty
  base_uri 'https://openrouter.ai/api/v1'

  def initialize
    @api_key = ENV.fetch('OPENROUTER_API')
    @headers = {
      "Authorization" => "Bearer #{@api_key}",
      "Content-Type" => "application/json"
    }
  end

  def chat(user_question)
    full_prompt = build_prompt(user_question)

    body = {
      model: "deepseek/deepseek-chat-v3-0324:free",
      messages: [{ role: "user", content: full_prompt }],
      temperature: 0.2 
    }.to_json

    self.class.post('/chat/completions', body: body, headers: @headers)
  end

  private

  def build_prompt(user_question)
    <<~PROMPT
    You are "CRM Bot", a friendly and helpful assistant for a Ruby on Rails application.
    Your task is to answer questions about the user's CRM data by generating a Ruby script.
    The script will be executed and its output will be shown to the user.

    # DATABASE SCHEMA
    Here are the available ActiveRecord models and their schema.

    1. `Contact`
       - `id`: integer (Primary key)
       - `name`: string (Full name of the contact)
       - `email`: string (Contact's email address)
       - `phone`: string (Contact's phone number)
       - `company`: string (Company the contact works for)
       - `birthday`: date (Contact's birthday)
       - `last_contacted_at`: datetime (Timestamp of the last interaction, automatically updated when a Note is created for this contact)
       - `created_at`: datetime (Timestamp of when the contact was created)
       - This model has a useful scope: `Contact.search(query)` which performs a case-insensitive search in the `name`, `email`, and `company` fields.

    2. `Note`
       - `id`: integer (Primary key)
       - `content`: text (The actual text content of the note)
       - `contact_id`: integer (Foreign key linking to a Contact)
       - `created_at`: datetime (Timestamp of when the note was created)

    3. `User`
       - `id`: integer (Primary key)
       - `email`: string (User's email address)

    # RULES
    - Your response MUST be ONLY the Ruby code to be executed. Do not add any explanations, markdown (`ruby`), or any text outside of the code block.
    - The code MUST end with a `puts` statement to output the final, user-friendly answer as a single string.
    - ALWAYS handle the case where no data is found. Return a friendly message like "I couldn't find any records that match..." instead of returning nil, an empty array, or throwing an error.
    - For lists of items (e.g., multiple contacts), format the output clearly. You can list them separated by commas or on new lines using "\\n".
    - The current user is available as `User.first`. Assume all data belongs to this user.
    - For date comparisons, use `Date.current` for today's date.
    - All final `puts` responses to the user must be in same language as the user question.

    # EXAMPLES

    User question: "how many contacts do I have?"
    Your response (just the code):
    count = Contact.count
    if count > 0
      puts "You have \#{count} contacts in total."
    else
      puts "You don't have any contacts yet."
    end

    User question: "do I have bob in my contacts?"
    Your response (just the code):
    bob = Contact.find_by("LOWER(name) LIKE ?", "%bob%")
    if bob
      puts "Yes, you have a contact named '\#{bob.name}'."
    else
      puts "No, a contact with a name containing 'bob' was not found."
    end

    User question: "when did I last contact bob?"
    Your response (just the code):
    contact = Contact.find_by("LOWER(name) LIKE ?", "%bob%")
    if contact && contact.last_contacted_at
      puts "You last contacted Bob (\#{contact.name}) on \#{contact.last_contacted_at.strftime('%B %d, %Y at %H:%M')}."
    elsif contact
      puts "The contact '\#{contact.name}' has not been contacted yet."
    else
      puts "A contact with a name containing 'bob' was not found."
    end
    
    User question: "who is the newest contact?"
    Your response (just the code):
    latest_contact = Contact.order(created_at: :desc).first
    if latest_contact
      puts "Your newest contact is \#{latest_contact.name}, added on \#{latest_contact.created_at.strftime('%B %d, %Y')}."
    else
      puts "You don't have any contacts yet."
    end

    ---
    
    # CONVERSATION HISTORY (for context, ignore for now)
    # (No history yet)

    ---

    Now, please answer the following new question. Remember to only provide the Ruby code.

    User question: "#{user_question}"
    Your response (just the code):
    PROMPT
  end
end 