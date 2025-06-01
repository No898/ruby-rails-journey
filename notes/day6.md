# ✅ Day 6 – UI Components & ViewComponent Exploration

**Date:** 1 June 2025

---

## 🎯 Goal

Explore the ViewComponent gem in Rails, practice structuring reusable UI elements, and refactor views using a component-based approach similar to React.

---

## ✅ What I did

### 1. Exercism: `chess_game` & `luhn`

- Solved two Ruby exercises:
  - `chess_game`: validated board positions and generated player nicknames
  - `luhn`: implemented the Luhn algorithm for validating numbers
- These helped me practice string manipulation, conditionals, and writing helper methods in Ruby.

---

### 2. View Exploration: Introducing ViewComponent

- Started reading the official documentation for [`ViewComponent`](https://viewcomponent.org), a gem that brings encapsulated, testable components to Rails views.
- Created two reusable components:
  - `ButtonComponent` with support for variants (`:primary`, `:secondary`) and light/dark theme
  - `NoticeComponent` for rendering flash messages (`notice`, `alert`)
- Realized that Rails can adopt a component-based view structure, very similar to what I'm used to in React.

---

### 3. UI Refactor with Components

- Replaced raw `<a>` and `<button>` tags in contact and note views with `ButtonComponent` to ensure consistent styling.
- Updated `flash` messages in the layout to use the new `NoticeComponent`.
- Simplified the theme toggle to use emoji icons for light/dark mode instead of custom SVGs.
- Improved overall maintainability of UI by reducing duplication and centralizing logic into components.

---

## 💡 What I learned

- Rails doesn't ship with ViewComponent, but adding it gives you a modern, testable approach to UI development.
- Components improve readability, reusability, and separation of concerns, even in traditional server-rendered apps.
- It's a good practice to extract buttons, flash messages, and common UI logic into ViewComponents early on.

---

## 🔭 Next Steps

Tomorrow I'd like to dive into **user management and authentication** using `has_secure_password`, sessions, and user-related views. This will bring the app closer to being production-ready.
