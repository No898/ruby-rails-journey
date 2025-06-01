# 📇 Mini CRM

Mini CRM is a lightweight customer relationship management system built with Ruby on Rails 8. It's designed to help you manage contacts and notes, with a clean UI powered by Tailwind CSS and full dark mode support.

---

## ✅ Features Implemented

### 📁 Contact Management
- [x] Create, edit, and delete contacts
- [x] Show individual contact details
- [x] Responsive layout with Tailwind CSS

### 📝 Notes Management
- [x] Add notes to contacts
- [x] Notes listed in descending order
- [x] Each note tracks author (user) and timestamp
- [x] Show individual note detail page
- [x] Edit and delete notes with confirmation

### 🔒 Authentication
- [x] Devise integration for user registration and login
- [x] Only signed-in users can manage data
- [x] User info (email + sign out) visible in top right corner

### ✨ UI Components & Theming
- [x] Reusable `ButtonComponent` with variants (primary, secondary, danger, link)
- [x] `NoticeComponent` for flash messages (styled success alerts)
- [x] Dark mode support (based on system preference or toggle)
- [x] Toggle dark mode with persistent theme in localStorage
- [x] Responsive design for mobile/tablet/desktop
- [x] Emoji-based theme toggle icon ☀️🌙

### 🔍 Contact Search
- [x] Full-text search by name, email, or company
- [x] Case-insensitive partial match (`ILIKE` in PostgreSQL)

### 💡 UX & Navigation
- [x] "Mini CRM" top-left link to homepage
- [x] Welcome landing page with feature list and action buttons
- [x] Navigation adapts based on authentication state
- [x] Inline destroy confirmation via `data-turbo-confirm`

### 🛡 Error Handling
- [x] Custom `ActiveRecord::RecordNotFound` handling in controllers
- [x] Inline form error display with Tailwind styling

---

## 🔧 Setup Instructions

```bash
bundle install
bin/rails db:create db:migrate
gem install foreman --user-install # if not already installed
bin/dev # Starts Rails + Tailwind + Turbo
```

You’ll need:

- Ruby ≥ 3.2
- Node.js + Yarn
- PostgreSQL or SQLite (default)

---

## 🛠 Features To Implement

### 🗓 Birthday & Last Contact Date
- [ ] Add `birthday:date` and `last_contacted_at:datetime` to contacts
- [ ] Auto-update `last_contacted_at` when a note is added

### 📊 Statistics
- [ ] Count notes per contact
- [ ] Show most recent note inline
- [ ] Add “Active Contacts” filter

### 🖌 Improved Layout
- [ ] Card-based UI for contact list
- [ ] Sidebar layout: contacts on left, notes on right
- [ ] Icons (e.g. Heroicons or Lucide)

---

## 🧪 Testing (Planned)
- [ ] System tests for contacts and notes
- [ ] Edge case coverage for forms and redirects

---

Mini CRM is ideal for learning modern Rails, Turbo, and Tailwind workflows. Clean, minimal, and extendable.