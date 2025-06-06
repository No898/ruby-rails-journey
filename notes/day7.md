# ✅ Day 7 – Authentication, Landing Page & Contact Search

**Date:** 2 June 2025

---

## 🎯 Goal

Implement secure user authentication using Devise, improve the UI for user sessions, and enhance the search functionality for contacts.

---

## ✅ What I did

### 1. Devise Authentication Setup

- Researched the most common Rails authentication solutions: **Devise**, **OmniAuth** and more
- Chose **Devise**, since OmniAuth is mainly used for third-party logins (Google, GitHub…)
- Implemented basic **Devise** setup:
  - User registration, login, logout
  - Authentication required for accessing contacts and notes

---

### 2. UI Enhancements

- Added a **user bar in the top right corner** showing the email and logout link
- Added a **"Mini CRM" logo/link in the top left**, linking back to the homepage
- Created a **landing page** (`home#index`) describing app features with different buttons depending on login status

---

### 3. Search Bar Improvements

- Added a search field above the contacts list
- Supports searching by:
  - Name
  - Email
  - Company

---

## 💡 What I learned

- Devise is a super fast way to secure Rails apps without building custom authentication logic
- Contact search can be implemented easily with `form_with` and controller filtering—no JS required

---

## 🔭 Next Steps

- Add `birthday` and `last_contacted_at` fields to contacts
- Automatically update `last_contacted_at` after creating a note
- Consider to add tests for login and CRUD actions