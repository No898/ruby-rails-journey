# 📇 Mini CRM

Mini CRM is a lightweight customer relationship management system built with Ruby on Rails. It's designed to help you manage contacts and notes, with a simple, elegant UI powered by Tailwind CSS.

## ✅ Features Implemented

### 📁 Contact Management
- [x] Create, edit, and delete contacts
- [x] Show individual contact details
- [x] Basic styling with Tailwind

### 📝 Notes
- [x] Add notes to contacts
- [x] Notes listed in descending order

### 🗑 Delete Notes
- [x] Each note should have a **Delete** button
- [x] It will call the `destroy` method in the `NotesController`

## 🔧 Setup Instructions

```bash
bundle install
bin/rails db:create db:migrate
gem install foreman --user-install # if not already installed
bin/dev # Starts Rails + Tailwind
```

Ensure you have Ruby >= 3.2 and Node.js/Yarn installed.

---

## 🛠 Features To Implement

### 🔍 Contact Search
- [ ] Full-text search by name, email, or company
- [ ] Partial match using `ILIKE` (PostgreSQL)

### 🗓 Birthday & Last Contact Date
- [ ] Add fields `birthday:date` and `last_contacted_at:datetime` to contacts
- [ ] Automatically update `last_contacted_at` when a note is added

### 📊 Statistics
- [ ] Show number of notes per contact
- [ ] Display the most recent note
- [ ] Add "Show Active Contacts" button

### 🖌 Improved Layout
- [ ] Wrap contacts in **Tailwind cards**
- [ ] Split layout into columns (sidebar, detail, notes)
- [ ] Use icons (e.g. Heroicons)

---

### 🧪 Testing
- [ ] Add system tests for contacts and notes
- [ ] Validate form submissions and edge cases

Starting with the first feature: **Delete Notes** — we'll implement it step by step. ✅