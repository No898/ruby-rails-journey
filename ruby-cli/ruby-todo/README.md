# 📘 Ruby CLI To-Do App

A simple and colorful command-line To-Do application written in pure Ruby.
Tasks are saved locally in a JSON file so your list survives after closing the app.

---

## ⚙️ Features

* `add` — Add a new task
* `list` — List all tasks
* `done` — Mark a task as done
* `remove` — Remove a specific task
* `clear` — Remove all tasks
* `help` — Show available commands
* `exit` — Quit the app

All changes are automatically saved to `tasks.json`.

---

## 🚀 Getting Started

### 1. Clone the project

```bash
git clone https://github.com/yourusername/ruby-todo.git
cd ruby-todo
```

### 2. Run the app

```bash
ruby todo.rb
```

No gems needed. Works out of the box with Ruby ≥ 2.5.

---

## 📂 File Structure

```bash
ruby-todo/
├── task.rb       # Task class (defines what a task is)
├── todo.rb       # Main CLI app
├── tasks.json    # Automatically generated, stores your tasks
```

---

## 💡 Example Usage

```bash
> add
Write task description:
Buy oat milk
Task added

> list
1. ⏳ In progress - Buy oat milk

> done
Write number of task to mark as DONE:
1
Task n. 1 marked as done

> list
1. ✅ Done       - Buy oat milk
```

---

## 📚 License

MIT License. Do whatever you want.

---

Made with ❤️ in Ruby.
