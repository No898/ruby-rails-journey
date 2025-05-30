class AddBirthdayAndLastContactedAtToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :birthday, :date
    add_column :contacts, :last_contacted_at, :datetime
  end
end
