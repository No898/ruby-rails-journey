# 🤖 AI Terminal Chat (Ruby + OpenRouter)

A minimal command-line chatbot written in **pure Ruby**, powered by OpenRouter.ai and connected to a free Large Language Model (LLM)  **Gemini 2.0 Flash**.

This project was built as a fast, educational prototype to explore Ruby fundamentals: working with APIs, HTTP requests, JSON parsing, terminal input/output, and environment variables all in a few minutes.

---

## 🧠 Why This Exists

I wanted to:

- Practice Ruby’s standard library (without external frameworks)
- Build something small but functional using an **LLM API**
- Understand how HTTP requests and JSON payloads work in Ruby
- Keep it terminal-based and beginner-friendly

---

## ✨ Features

- 🤝 Supports **OpenRouter** API with multiple free LLMs
- 📡 Sends & receives chat messages via simple HTTP `POST`
- 🗣 Maintains conversation context using `messages[]` array
- 🔐 Loads API key from `.env` file (via `dotenv` gem)
- 💥 Gracefully handles errors (e.g., invalid key, rate limits)

---

## 🔧 Requirements

- Ruby 3.0 or later
- [OpenRouter API key](https://openrouter.ai/settings)
- Bundler (`gem install bundler` if not installed)

Install dependencies:

```bash
bundle install
```

---

## 🔐 Setup

1. Create a `.env` file in the project root:

```
OPENROUTER_API_KEY=your_openrouter_key_here
```

2. Set your desired model (optional). The default model is:

```ruby
MODEL = 'google/gemini-2.0-flash-exp:free'
```

Other great free models you can use:

- `deepseek/deepseek-chat-v3-0324:free`
- `meta-llama/llama-4-scout:free`
- `mistralai/mistral-small-3.1-24b-instruct:free`

---

## 🚀 Run the App

```bash
ruby ai-chat.rb
```

Example interaction:

```
💬 AI Chat bot CLI Chat (via OpenRouter)
Type 'exit' to quit.
You > Hey, Who are you?
AI Chat bot > I am an artificial intelligence ready to assist you with anything. 🙂
```

---

## 🛠 File Structure

```
ai-terminal/
├── .env                # API key (not committed)
├── ai-chat.rb          # Main Ruby script
├── Gemfile             
└── README.md

```

---

## 🧩 Future Ideas

- Switch models via CLI flag (`--model`)
- Use streaming (`stream: true`) instead of full output
- Save conversation logs to `.txt` or `.md`
- Make it into a gem or interactive REPL tool

---

## 📜 License

MIT — use, fork, learn, improve.
