# 🚃 Ruby & Rails Journey

This repository documents my personal learning journey with **Ruby** and **Ruby on Rails**.
My goal is to gain a solid understanding of both the language and the framework — through small projects, real exercises, and gradual, consistent practice.

I treat this as a **public playground**, portfolio piece, and study log — everything I learn is tracked here.

---

## ⚙️ Project CLI Helper (`exe.rb`)

To streamline working with Exercism Ruby exercises, this project includes a simple **interactive CLI helper script** named `exe.rb` (located in the project root).

### What does `exe.rb` do?

* **Interactive testing and submission** — You can run tests or submit solutions for any exercise by simply selecting options in the terminal, without typing long paths or filenames.
* **Automatic path discovery** — The script will list all available exercises and valid files, so you always select the right one.
* **Cross-platform** — Works out of the box on Windows, Mac, and Linux (requires only Ruby).

### How does it work?

1. Run the script in your terminal:

   ```bash
   ruby exe.rb
   ```

2. Choose your action:

   * `test` — run the exercise's test file
   * `submit` — submit your solution to Exercism

3. Select the exercise folder
   You get a menu of all available exercises.

4. Select the file
   The script lists relevant Ruby files for the chosen action:

   * For `test`, it lists all `*_test.rb` files.
   * For `submit`, it lists all `.rb` files except tests.

5. The script runs or submits your selection and prints output or Exercism URL.

### Why did I create it?

Because I'm lazy 😄, instead of typing long commands or guessing file paths, I wrote this helper to save time and avoid mistakes.

### Example usage

```bash
ruby exe.rb
```

Sample session:

```
Choose action:
1) test
2) submit
> 1

Choose folder:
1) lasagna
2) reverse-string
...

Choose file:
1) lasagna_test.rb
...

Running: ruby -r minitest/pride exercism/ruby/lasagna/lasagna_test.rb
...
```

### Note for Windows users

This script is a plain Ruby script and works anywhere Ruby does — including Windows (CMD, PowerShell, Git Bash, or WSL).
No Bash or extra libraries needed.

### Requirements

* Ruby installed (any recent version is fine)
* [Exercism CLI](https://exercism.org/docs/using/cli) installed and authenticated (for `submit` command)



To keep your Ruby exercises organized and ensure they integrate seamlessly with this repository structure, make sure your Exercism CLI is properly configured.

By default, Exercism downloads exercises into a generic workspace. In this repository, we use the folder:

```
./exercism/ruby
```

### ✅ Configuration Steps

Follow these steps to configure Exercism CLI to use the correct folder:

1. Open your terminal
2. Run the following command:

   ```bash
   exercism configure --workspace=./exercism
   ```

3. Now, when downloading Ruby exercises, make sure you're inside the root of this repo:

   ```bash
   cd path/to/ruby-rails-journey
   exercism download --track ruby --exercise <exercise-name>
   ```

### 📌 Result

Ruby exercises will now be saved into:

```
./exercism/ruby/<exercise-name>
```

This setup matches the structure used throughout this project and ensures everything stays tidy and consistent.


---

## 📁 Folder Setup for Exercism CLI

To keep your Ruby exercises organized and ensure they integrate seamlessly with this repository structure, make sure your Exercism CLI is properly configured.

By default, Exercism downloads exercises into a generic workspace. In this repository, we use the folder:

```
./exercism/ruby
```

### ✅ Configuration Steps

Follow these steps to configure Exercism CLI to use the correct folder:

1. Open your terminal
2. Run the following command:

   ```bash
   exercism configure --workspace=./exercism
   ```

3. Now, when downloading Ruby exercises, make sure you're inside the root of this repo:

   ```bash
   cd path/to/ruby-rails-journey
   exercism download --track ruby --exercise <exercise-name>
   ```

### 📌 Result

Ruby exercises will now be saved into:

```
./exercism/ruby/<exercise-name>
```

This setup matches the structure used throughout this project and ensures everything stays tidy and consistent.
---

## 🎯 Learning Objectives

### 🧠 Ruby (The Language)

#### ✅ 1. Fundamentals

* [x] Data types: `Integer`, `Float`, `String`, `Symbol`, `Boolean`, `NilClass`
* [x] Variables: local, global, instance (`@`), class (`@@`)
* [x] Conditionals: `if`, `elsif`, `else`, `unless`, ternary operator
* [x] Loops: `while`, `until`, `for`, `loop`, `each`
* [x] Methods: definition, parameters, return values
* [x] Blocks: `do..end`, `{}` syntax
* [x] Arrays and Hashes: CRUD, iteration
* [x] String manipulation: `split`, `gsub`, `interpolation`, `upcase`, etc.
* [x] File handling: `File.read`, `File.write`, working with `JSON` and `CSV`
* [x] Exception handling: `begin`, `rescue`, `ensure`
* [x] `require`, `load`, working with gems

#### 🧱 2. OOP & Idiomatic Ruby

* [x] Classes and objects, constructors (`initialize`), `self`
* [x] `attr_accessor`, `attr_reader`, `attr_writer`
* [x] Inheritance (`<`) and calling `super`
* [ ] Modules: `module`, `include`, `extend`
* [ ] Method introspection: `respond_to?`, `send`, `method_missing`
* [ ] `yield`, `block_given?`, `Proc`, `lambda`, closures
* [x] Enumerable module: `map`, `select`, `reject`, `reduce`, etc.
* [x] Symbols vs Strings — performance and semantics
* [x] Time and Date classes: `Time.now`, `Date.today`
* [x] Regular expressions: `/pattern/`, `match?`, `scan`, `gsub`
* [ ] Standard library: `OpenStruct`, `Struct`, `Set`, etc.

#### 🧪 3. Practical Extras

* [x] Gemfile & Bundler: `bundle init`, `bundle install`, `bundle exec`
* [ ] Debugging: `puts`, `p`, `irb`, `pry`, `byebug`
* [ ] Testing: `Minitest` basics (optionally `RSpec`)
* [x] CLI scripting: `ARGV`, `OptionParser`
* [x] Using environment variables: `ENV['SOME_KEY']`
* [ ] Documentation tools: `ri`, `yard`, [rubydoc.info](https://rubydoc.info)
* [ ] (Optional) Writing your own gem

---

### 🚂 Ruby on Rails (The Framework)

* [x] Project structure and Rails conventions
* [x] MVC architecture (Model–View–Controller)
* [x] Generators and scaffolding
* [x] Routing and RESTful resources
* [x] CRUD with Active Record
* [x] Model validations and constraints
* [x] Working with forms (`form_with`, strong params)
* [x] Custom views, layouts, and partials
* [x] Flash messages and sessions
* [x] **ViewComponent architecture** for reusable components
* [x] **Devise authentication** with full authorization
* [x] Nested resources and associations (`has_many`, `belongs_to`)
* [x] Database migrations and schema design
* [x] **Comprehensive testing** (Minitest with extensive test suite - 118 tests)
* [x] Environment configs and secrets
* [x] Git project structure and .gitignore best practices
* [x] **Modern frontend** with Turbo + Stimulus + Tailwind CSS
* [x] **Localization and internationalization** (Czech translation)
* [x] **Dark mode implementation** with system preference detection
* [ ] (Optional) Deployment to Render / Fly.io / Railway

---

## 🛠 Projects in This Repo

### `/ruby-cli`

Small Ruby command-line projects built to practice the language.

### `/ruby-cli/ruby-todo`

A fully functional command-line To-Do app written in Ruby. Tasks are stored in a JSON file for persistence.
Supports: `add`, `list`, `done`, `remove`, `clear`. Automatically saves changes.

### `/ruby-cli/ai-terminal`

A simple Ruby terminal chatbot that connects to OpenRouter's LLM APIs (e.g. Gemini 2.0 Flash, DeepSeek) using HTTP requests and environment variables.  
Designed to explore how to work with APIs, handle `.env`, and build interactive CLI tools in pure Ruby.

### `/exercism/ruby`

All Ruby track exercises from Exercism, solved sequentially with test coverage and progressive difficulty.

### `/rails`

Rails applications using MVC structure, built during exploration.

### `/rails/mini_crm`

Advanced **mini CRM application** built on Ruby on Rails 8 with modern architecture and comprehensive functionality:

#### 🎯 **Key Features:**
- **Complete contact management** with CRUD operations, search, and active status
- **Advanced notes system** with dual creation (from contacts or standalone) and authorization
- **ViewComponent architecture** with 4 reusable components (Button, Notice, Avatar, Badge)
- **Complete Czech localization** including proper grammar and pluralization
- **Dark mode support** with system preference detection
- **Professional UI design** with card layouts, avatars, and breadcrumb navigation
- **Comprehensive test suite** with 118 tests covering all features
- **Devise authentication** with full authorization and user management

#### 🛠 **Technical Stack:**
- Ruby on Rails 8 + SQLite
- Tailwind CSS + ViewComponent + Heroicons
- Turbo + Stimulus for modern frontend
- Devise for authentication
- Minitest with comprehensive testing

This project demonstrates modern Rails development patterns, component-based architecture, professional UI design, and extensive testing coverage.

### `/notes`

Topic-based notes and study logs, organized by day (`day1.md`, `day2.md`, ...).

---

## 🧪 Completed Exercises

* ✅ [Try Ruby](https://try.ruby-lang.org/)
* ✅ Exercism:

  * [x] hello-world
  * [x] lasagna
  * [x] amusement-park (attendee)
  * [x] amusement-park-improvements
  * [x] reverse-string
  * [x] log-line-parser
  * [x] assembly-line
  * [x] savings-account
  * [x] port-palermo
  * [x] two-fer
  * [x] acronym
  * [x] isogram
  * [x] word-count
  * [x] simple-calculator
  * [x] chess-game
  * [x] luhn
  * [x] blackjack
  * [x] eliuds-eggs
  * [x] bird-count
  * [x] bowling

(More to come...)

---

## 📚 Resources I'm Using

### 🧠 Ruby

* [Ruby package repository](https://rubygems.org/)
* [Ruby Documentation](https://ruby-doc.org/3.4.1/index.html)
* [Try Ruby (try.ruby-lang.org)](https://try.ruby-lang.org/)
* [The Odin Project – Ruby Path](https://www.theodinproject.com/paths/full-stack-ruby-on-rails)
* [Pry – Ruby REPL and debugging console](https://github.com/pry/pry)
* [Ruby Koans](http://rubykoans.com/)
* [Exercism – Ruby Track](https://exercism.org/tracks/ruby)

### 🚂 Ruby on Rails

* [Ruby on Rails Official channel](https://www.youtube.com/watch?v=X_Hw9P1iZfQ)
* [Ruby on Rails Guides](https://guides.rubyonrails.org/)
* [Rails Girls Guides](https://guides.railsgirls.com/)
* [RoR Guides and learning path](https://gorails.com/)

---

## ✨ About

I'm a fullstack developer expanding my backend and Ruby skill set through real-world practice.
This repo is my public learning log and technical growth tracker built one day, one lesson at a time.
