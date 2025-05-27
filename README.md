# 🛤 Ruby & Rails Journey

This repository documents my personal learning journey with **Ruby** and **Ruby on Rails**.  
My goal is to gain a solid understanding of both the language and the framework — through small projects, real exercises, and gradual, consistent practice.

I treat this as a **public playground**, portfolio piece, and study log — everything I learn is tracked here.

---

## 🎯 Learning Objectives

### 🧠 Ruby (The Language)

#### ✅ 1. Fundamentals
- [X] Data types: `Integer`, `Float`, `String`, `Symbol`, `Boolean`, `NilClass`
- [X] Variables: local, global, instance (`@`), class (`@@`)
- [X] Conditionals: `if`, `elsif`, `else`, `unless`, ternary operator
- [X] Loops: `while`, `until`, `for`, `loop`, `each`
- [X] Methods: definition, parameters, return values
- [X] Blocks: `do..end`, `{}` syntax
- [X] Arrays and Hashes: CRUD, iteration
- [X] String manipulation: `split`, `gsub`, `interpolation`, `upcase`, etc.
- [ ] File handling: `File.read`, `File.write`, working with `JSON` and `CSV`
- [ ] Exception handling: `begin`, `rescue`, `ensure`
- [ ] `require`, `load`, working with gems

#### 🧱 2. OOP & Idiomatic Ruby
- [ ] Classes and objects, constructors (`initialize`), `self`
- [ ] `attr_accessor`, `attr_reader`, `attr_writer`
- [ ] Inheritance (`<`) and calling `super`
- [ ] Modules: `module`, `include`, `extend`
- [ ] Method introspection: `respond_to?`, `send`, `method_missing`
- [ ] `yield`, `block_given?`, `Proc`, `lambda`, closures
- [ ] Enumerable module: `map`, `select`, `reject`, `reduce`, etc.
- [ ] Symbols vs Strings — performance and semantics
- [ ] Time and Date classes: `Time.now`, `Date.today`
- [ ] Regular expressions: `/pattern/`, `match?`, `scan`, `gsub`
- [ ] Standard library: `OpenStruct`, `Struct`, `Set`, etc.

#### 🧪 3. Practical Extras
- [ ] Gemfile & Bundler: `bundle init`, `bundle install`, `bundle exec`
- [ ] Debugging: `puts`, `p`, `irb`, `pry`, `byebug`
- [ ] Testing: `Minitest` basics (optionally `RSpec`)
- [ ] CLI scripting: `ARGV`, `OptionParser`
- [ ] Using environment variables: `ENV['SOME_KEY']`
- [ ] Documentation tools: `ri`, `yard`, [rubydoc.info](https://rubydoc.info)
- [ ] (Optional) Writing your own gem

---

### 🚂 Ruby on Rails (The Framework)
- [ ] Project structure and Rails conventions
- [ ] MVC architecture (Model–View–Controller)
- [ ] Generators and scaffolding
- [ ] Routing and RESTful resources
- [ ] CRUD with Active Record
- [ ] Model validations and constraints
- [ ] Working with forms (`form_with`, strong params)
- [ ] Custom views, layouts, and partials
- [ ] Flash messages and sessions
- [ ] Manual user authentication (no Devise)
- [ ] Nested resources and associations (`has_many`, `belongs_to`)
- [ ] Database migrations and schema design
- [ ] Testing basics (Minitest or RSpec)
- [ ] Environment configs and secrets
- [ ] Git project structure and .gitignore best practices
- [ ] (Optional) Deployment to Render / Fly.io / Railway

---

## 🛠 Projects in This Repo

### `/ruby-cli`
Small Ruby command-line projects built to practice the language.

### `/exercism/ruby`
All Ruby track exercises from Exercism, solved sequentially with test coverage and progressive difficulty.

### `/rails`
Rails applications using MVC structure, built during exploration.

### `/notes`
Topic-based notes and study logs, organized by day (`day1.md`, `day2.md`, ...).

---

## ⚙️ Project CLI helper (`exe`)

To streamline working with Exercism Ruby exercises, this project includes a simple **CLI helper script** named `exe` (located in the project root).

### What does `exe` do?

- **Simplifies running tests** — instead of writing the full `ruby -r minitest/pride path/to/test_file.rb`,  
  you can just run:

  ```bash
  ./exe test lasagna
  ```

  This automatically runs the test file located at `exercism/ruby/lasagna/lasagna_test.rb`.

- **Simplifies submitting solutions** — instead of writing the full `exercism submit path/to/solution.rb`,  
  you can just run:

  ```bash
  ./exe submit lasagna
  ```

  This automatically submits the implementation file `exercism/ruby/lasagna/lasagna.rb`.

### Why did I create it?

Because I'm lazy 😄 instead of typing long commands over and over, I made this little CLI helper to save time and keystrokes.

### How does it work?

- The script uses the exercise name (e.g. `lasagna`) to build paths to the test and implementation files inside the `exercism/ruby` directory.
- It then runs the appropriate command (`ruby` for tests, `exercism submit` for submission) with those paths.
- You can also pass additional arguments if needed.

### Usage examples

```bash
./exe test lasagna
./exe submit lasagna
./exe test reverse-string
./exe submit reverse-string
```

---

### Note for Windows users

This script is a bash shell script and works out of the box in environments like Git Bash or WSL on Windows.

---

## 🧪 Completed Exercises

- ✅ [Try Ruby](https://try.ruby-lang.org/)
- ✅ Exercism:
  - [x] hello-world
  - [x] lasagna
  - [x] amusement-park (attendee)
  - [x] reverse-string

(More to come...)

---

## 📚 Resources I'm Using

### 🧠 Ruby

- [Try Ruby (try.ruby-lang.org)](https://try.ruby-lang.org/)
- [The Odin Project – Ruby Path](https://www.theodinproject.com/paths/full-stack-ruby-on-rails)
- [Pry – Ruby REPL and debugging console](https://github.com/pry/pry)
- [Ruby Koans](http://rubykoans.com/)
- [Exercism – Ruby Track](https://exercism.org/tracks/ruby)

### 🚂 Ruby on Rails

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Rails Girls Guides](https://guides.railsgirls.com/)

---

## ✨ About

I'm a fullstack developer expanding my backend and Ruby skill set through real-world practice.  
This repo is my public learning log and technical growth tracker built one day, one lesson at a time.
