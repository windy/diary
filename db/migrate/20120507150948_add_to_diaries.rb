class AddToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :user_id, :integer
  end

end
