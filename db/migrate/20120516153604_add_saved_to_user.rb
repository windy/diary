class AddSavedToUser < ActiveRecord::Migration
  def change
    add_column :users, :saved, :text
  end
end
