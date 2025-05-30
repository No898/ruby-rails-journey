# ✅ Day 4 – Simple Calculator, Exceptions & Mini CRM

**Date:** 30 May 2025

---

## 🎯 Goal

Today I wanted to dig deeper into exception handling in Ruby, understand how Rails handles real-time updates, and get more hands-on with building fullstack features using Rails.

---

## ✅ What I did

### 1. Exercism: `simple-calculator`

* Implemented a basic calculator that supports `+`, `/`, and `*`
* Practiced custom exception handling with `UnsupportedOperation`
* Learned how to use `begin...rescue` blocks — Ruby's equivalent of `try...catch` in JavaScript

```ruby
begin
  # code
rescue SomeError
  # handle error
end
```

| JavaScript / TypeScript | Ruby                            |
|--------------------------|----------------------------------|
| `Error`                  | `StandardError`                 |
| `TypeError`              | `TypeError` (exists in Ruby too!) |
| `RangeError`             | `RangeError`                    |
| *(custom error class)*   | `ArgumentError`, `CustomError`  |

---

### 2. Real-time in Rails: ActionCable vs. Alternatives

I explored how Rails handles real-time features using **ActionCable** (built-in WebSocket support). While it's great for small apps (chat, notifications, dashboards), it's not suitable for high-scale apps.

I also learned about:

* **SSE (Server-Sent Events)** — good for streaming logs or job status updates
* **Polling** — simple but not efficient for real-time UX

| Method              | Bidirectional? | Best For                      | Complexity |
|---------------------|----------------|-------------------------------|------------|
| ActionCable         | ✅ Yes         | Chats, notifications, dashboards | 🟨 Medium |
| Polling             | ❌ No          | Simple dashboards             | 🟩 Low     |
| Server-Sent Events  | ❌ No          | Logs, async job status        | 🟨 Medium  |

---

### 3. Rails: Impressions & UI Realization

I started working more seriously with Rails and realized that it doesn’t offer built-in UI component libraries like React. Rails is more backend-focused, fast, practical, and great for rapid development, but not very frontend-centric.

That made me consider eventually combining Rails with React or another frontend framework, but for now, I’ll keep learning Rails as-is.

---

### 4. Creating a Mini CRM

I built a small CRM app in Rails and found the experience surprisingly smooth. Backend logic is very clean. `html.erb` views take some time to get used to — not as readable as JSX or templating in frontend frameworks — but it’s manageable.

I also learned about `Time.now` vs `Time.current`. The latter is timezone-aware and preferred in Rails apps.

---

## 💼 Project Features

### 📁 Contact Management
- [x] Create, edit, delete contacts
- [x] View individual contact details
- [x] Basic Tailwind styling

### 📝 Notes
- [x] Add notes to contacts
- [x] List notes in descending order

### 🗑 Delete Notes
- [x] Each note has a **Delete** button
- [x] Deletes via `destroy` method in `NotesController`

I also implemented a **dark theme** toggle since the default white background was harsh at night — and I wanted to learn how to apply themes in Rails.

---

## 🔭 Next Steps

Tomorrow I’d like to explore how the frontend works within the MVC structure and maybe start experimenting with more dynamic interactions.
