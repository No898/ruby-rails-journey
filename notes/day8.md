# ✅ Day 8 – Exercism Practice & Contact Stats

**Date:** 2 June 2025

---

## 🎯 Goal

Continue practicing Ruby through Exercism challenges and improve the CRM UI with contact statistics.

---

## ✅ What I did

### 1. Ruby Practice via Exercism

- Completed two exercises:
  - ✅ `blackjack`
  - ✅ `eliuds-eggs`
- Reviewed conditional logic using `case` vs. `if`/`elsif`
- I already knew `case`, but noticed that **Node.js actually has a cleaner and more elegant syntax** in some scenarios

Example in Ruby:

```ruby
case sum
when 4..11 then "low"
when 12..16 then "mid"
when 17..20 then "high"
when 21 then "blackjack"
else "invalid cards"
end
```

---

### 2. Added Basic Contact Statistics

- Displayed the **note count** per contact
- Displayed the **last note inline** (truncated content)
- Added a UI **filter for "Active Contacts"**
- Added a checkbox to mark contacts as active/inactive in the form

---

## 💡 What I learned

- Ruby’s syntax is expressive, but some conditionals are more concise in Node.js
- Displaying basic stats like note counts and last notes is easy with well-structured models and partials
