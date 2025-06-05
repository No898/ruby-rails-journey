# 📇 Mini CRM

Mini CRM is a lightweight customer relationship management system built with Ruby on Rails 8. It's designed to help you manage contacts and notes, featuring a modern UI powered by Tailwind CSS, ViewComponent architecture, complete Czech localization, and full dark mode support.

---

## ✅ Features Implemented

### 📁 Contact Management
- [x] **Complete CRUD operations** for contacts (create, read, update, delete)
- [x] **Contact detail pages** with sidebar layout for notes
- [x] **Card-based contact listings** with avatars and metadata
- [x] **Contact information fields**: name, email, phone, company, birthday, active status
- [x] **Form validation** with proper field types and error messages
- [x] **Contact search** by name, email, or company with search scope

### 📝 Notes Management
- [x] **Dual creation methods**: from contact pages or standalone notes page
- [x] **Flexible routing**: nested under contacts + independent routes
- [x] **Contact selection dropdown** when creating standalone notes
- [x] **Notes listed in card layout** with author avatars and timestamps
- [x] **Individual note detail pages** with contact sidebar information  
- [x] **Full CRUD operations** with proper authorization (only note authors can edit/delete)
- [x] **Rich metadata display**: author, creation/update times, contact association

### 🔒 Authentication & Authorization
- [x] **Devise integration** for user registration and login
- [x] **User session management** with sign in/out functionality
- [x] **Authorization checks**: only signed-in users can manage data
- [x] **Note ownership validation**: only authors can edit/delete their notes
- [x] **User information display** in navigation (email + sign out)

### ✨ UI Components & Architecture
- [x] **ViewComponent integration** with 4 reusable components:
  - [x] `ButtonComponent` with variants (primary, secondary, danger, link, etc.)
  - [x] `NoticeComponent` for flash messages with styled success/error alerts
  - [x] `AvatarComponent` with Gravatar + colored initials fallback system
  - [x] `BadgeComponent` with multiple variants (success, danger, secondary, etc.)
- [x] **Modern card-based UI** replacing basic table layouts
- [x] **Dark mode support** with system preference detection + manual toggle
- [x] **Fully responsive design** for mobile/tablet/desktop viewports

### 🎨 Professional Layout & Design
- [x] **Card-based interfaces** for all contact and note listings
- [x] **Sidebar layouts** on contact detail pages (contact info + notes)
- [x] **Breadcrumb navigation** across major pages
- [x] **Responsive grid layouts** with proper spacing
- [x] **Avatar system**: Gravatar integration with colored initials fallback
- [x] **Badge system** for status indicators and categorization
- [x] **Consistent typography and spacing** using Tailwind CSS utilities
- [x] **Icon integration** for contact fields (email, phone, company, birthday)

### 🔍 Search & Filtering
- [x] **Contact search** by name, email, or company
- [x] **Case-insensitive partial matching** using SQLite `LIKE`
- [x] **Search form** with responsive design
- [x] **Active contacts filter** for showing only active contacts

### 🌍 Czech Localization
- [x] **Czech translation** of user interface elements
- [x] **Czech form labels and navigation**
- [x] **Czech date formatting** for birthdays

### 💡 UX & Navigation
- [x] **Breadcrumb navigation** on major pages
- [x] **"Mini CRM" homepage link** in top navigation
- [x] **Welcome landing page** with authentication-based content
- [x] **User authentication** with Devise
- [x] **Confirmation dialogs** for destructive actions

### 🗓 Contact Data & Tracking
- [x] **Birthday field** for contacts
- [x] **Last contacted timestamp** tracking
- [x] **Company information** field
- [x] **Email and phone fields** with proper input types
- [x] **Contact-note relationships** with foreign key constraints
- [x] **Active status** field for contacts

### 📊 Statistics & Metadata
- [x] **Note count per contact** with proper pluralization
- [x] **Recent note preview** on contact cards
- [x] **Timestamp display** for notes
- [x] **Author attribution** for notes
- [x] **Contact activity tracking**

### 🛡 Error Handling
- [x] **Custom 404 handling** for `ActiveRecord::RecordNotFound`
- [x] **Flash messages** for success and error states
- [x] **Basic form validation** with Rails defaults

---

## 🔧 Setup Instructions

```bash
bundle install
bin/rails db:create db:migrate
gem install foreman --user-install # if not already installed
bin/dev # Starts Rails + Tailwind + Turbo
```

You'll need:

- Ruby ≥ 3.2
- Node.js + Yarn
- SQLite 

---

## 🧪 Testing Suite

### 📋 **Test Coverage**
Mini CRM includes a comprehensive test suite covering core functionality:

#### 🏗 **Model Tests** (`test/models/`)
- **Contact Model**: Validations, associations, search functionality, business logic
- **Note Model**: Content validation, associations, callback testing
- **User Model**: Devise authentication

#### 🎛 **Component Tests** (`test/components/`)
- **AvatarComponent**: Gravatar integration, initials fallback, sizing
- **ButtonComponent**: Variants, link/button logic, styling

#### 🎮 **Controller Tests** (`test/controllers/`)
- **ContactsController**: Authentication, authorization, CRUD, search
- **NotesController**: Notes and authorization
- **HomeController**: Landing page

#### 🖥 **System Tests** (`test/system/`)
- **End-to-End workflows**: Login, CRUD operations, search, navigation

### 🚀 **Running Tests**

```bash
# All tests at once with reporting
./bin/test_all

# Individual test suites
bin/rails test test/models/          # Model tests
bin/rails test test/controllers/     # Controller tests  
bin/rails test test/components/      # Component tests
bin/rails test:system               # System/E2E tests

# Specific test file
bin/rails test test/models/contact_test.rb
```

**Test Metrics:**
- **Model layer**: Validations, business logic, callbacks
- **Controller layer**: Authentication, authorization, CRUD
- **Component layer**: UI components, styling
- **System layer**: End-to-end workflows  
- **Total**: **118 tests with 277 assertions** covering all application features

---

## 🚀 Technical Stack

- **Backend**: Ruby on Rails 8, SQLite
- **Frontend**: Turbo, Stimulus, Tailwind CSS
- **Components**: ViewComponent architecture with 4 components
- **Authentication**: Devise
- **Testing**: Minitest with comprehensive test suite (118 tests)

---

Mini CRM demonstrates modern Rails development patterns with ViewComponent architecture, comprehensive Czech localization, professional UI design, and extensive testing coverage. Perfect for learning Rails 8, Turbo, component-based frontend development, and Ruby testing best practices.

---

**Note**: Advanced UI components, comprehensive testing suite, and Czech localization were developed with assistance from Claude 4 to accelerate development and demonstrate best practices in modern Rails applications.