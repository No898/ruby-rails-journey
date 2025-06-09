# 📇 Mini CRM

Mini CRM is a simple contact management system built with Ruby on Rails. It features a modern UI with dark mode support, Turbo for asynchronous updates, and an integrated AI assistant.

## ✨ Key Features

### 👥 Contact Management
- [x] **CRUD operations** for contacts (create, read, update, delete)
- [x] **Contact information**: name, email, phone, company, birthday
- [x] **Data validation**:
  - Email format validation
  - Phone number format validation
  - Birthday must not be in the future
- [x] **Contact search** by name, email, or company
- [x] **Automatic initials generation** for avatars
- [x] **Age calculation** from birthday

### 📝 Notes Management
- [x] **Complete notes management** for contacts
- [x] **Note validation**:
  - Minimum length: 3 characters
  - Maximum length: 1000 characters
  - Cannot contain only whitespace
- [x] **Automatic processing**:
  - Whitespace trimming
  - Last contact date updates
- [x] **Note ordering** from newest to oldest
- [x] **Note previews** with limited length

### 🤖 AI Assistant
- [x] **Integrated chat** for CRM queries
- [x] **Asynchronous communication** using Turbo
- [x] **Clean conversation display**
- [x] **Responsive chat design**

### 🔒 User System (Devise)
- [x] **Registration and login**
- [x] **Password recovery**
- [x] **Account management**
- [x] **Contact and note associations**

### 🎨 UI/UX
- [x] **Dark/Light mode**:
  - System preference detection
  - Manual toggle
  - Preference saving
- [x] **Responsive design**
- [x] **Modern look** with Tailwind CSS

### 🛡️ Security
- [x] **Authentication** with Devise
- [x] **Input validation**
- [x] **XSS and SQL injection protection**
- [x] **Proper data dependencies** (cascade deletion)

## 🔧 Installation

```bash
# Install dependencies
bundle install

# Create and migrate database
bin/rails db:create db:migrate

# Start server
bin/rails server
```

Requirements:
- Ruby ≥ 3.2
- SQLite
- Node.js (for Tailwind CSS)

## 🚀 Technology Stack

- **Backend**: Ruby on Rails
- **Frontend**: Turbo, Tailwind CSS
- **Database**: SQLite
- **Authentication**: Devise
- **AI**: OpenRouter API

## 👥 Authors

Created as part of learning Ruby on Rails with the help of AI assistant Claude.