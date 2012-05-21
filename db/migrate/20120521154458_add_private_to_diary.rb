class AddPrivateToDiary < ActiveRecord::Migration
  def change
    add_column :diaries, :private, :boolean
  end
end
