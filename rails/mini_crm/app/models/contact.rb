# app/models/contact.rb
class Contact < ApplicationRecord
    belongs_to :user
    has_many :notes, dependent: :destroy
  end
  