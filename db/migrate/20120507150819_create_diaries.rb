class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
