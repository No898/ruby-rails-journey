# app/models/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :contacts, dependent: :destroy
  has_many :notes, dependent: :destroy

  # Thread-safe current user accessor
  thread_mattr_accessor :current

  # Default scope to ensure we only get current user's data
  def self.default_scope
    if current
      where(id: current.id)
    else
      all
    end
  end
end
