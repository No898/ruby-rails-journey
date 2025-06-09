# app/models/note.rb
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  validates :content, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :content, format: { without: /\A\s*\z/, message: "can't be just whitespace" }

  before_save :strip_content
  after_create :update_contact_last_contacted_at

  # Default scope to ensure we only get current user's notes and order by creation date
  default_scope { 
    if User.current
      where(user: User.current).order(created_at: :desc)
    else
      order(created_at: :desc)
    end
  }

  def content_preview(length = 100)
    content.length > length ? "#{content[0...length]}..." : content
  end

  def owned_by?(user)
    self.user == user
  end

  private

  def strip_content
    self.content = content.strip if content
  end

  def update_contact_last_contacted_at
    contact.update(last_contacted_at: created_at)
  end
end