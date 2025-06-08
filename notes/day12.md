# ✅ Day 12 – Ruby Classes & Objects Practice

**Date:** 7 June 2025

---

## 🎯 Goal

Understand Ruby classes, objects, and the difference between class variables, instance variables, and class methods.

---

## ✅ What I did

- Implemented a `House` class with attributes `color` and `style`
- Tracked number of instances using a class variable `@@count`
- Defined:
  - `.count` – class method to return total instances
  - `.report_count_of_instances` – class method using `self.name`
  - `#details` – instance method to describe the house

---

## 💡 What I learned

- `@@` defines a class-level variable shared by all instances
- `self.method_name` defines a class method
- `attr_accessor` provides getter and setter for instance variables
- `initialize` sets instance state when object is created
- Good practice: keep logic cleanly separated between instance and class responsibilities

---
