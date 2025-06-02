class AddActiveToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :active, :boolean
  end
end
