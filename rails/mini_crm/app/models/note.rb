# app/models/note.rb
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  after_create :update_contact_last_contacted_at

  private

  def update_contact_last_contacted_at
    contact.update(last_contacted_at: created_at)
  end
end