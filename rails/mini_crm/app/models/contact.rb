# app/models/contact.rb
class Contact < ApplicationRecord
    belongs_to :user
    has_many :notes, dependent: :destroy

    validates :name, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
    validates :phone, format: { with: /\A[\+]?[\d\s\-\(\)]+\z/ }, allow_blank: true
    validates :birthday, comparison: { less_than_or_equal_to: Date.current }, allow_blank: true

    # Default scope to ensure we only get current user's contacts
    default_scope { where(user: User.current) if User.current }

    scope :search, ->(query) {
      where("LOWER(name) LIKE :query OR LOWER(email) LIKE :query OR LOWER(company) LIKE :query", 
            query: "%#{query.downcase}%")
    }

    def full_name
      name
    end

    def initials
      parts = name.split
      if parts.length == 1
        # For single name, take first two characters
        parts[0].slice(0, 2).upcase
      else
        # For multiple names, take first character of each
        parts.map(&:first).join.upcase.slice(0, 2)
      end
    end

    def age
      return nil unless birthday
      
      today = Date.current
      age = today.year - birthday.year
      age -= 1 if today < birthday + age.years
      age
    end

    private

    def update_last_contacted
      touch(:last_contacted_at)
    end
  end
  