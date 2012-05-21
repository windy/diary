class AddDefaultValueToDiary < ActiveRecord::Migration
  def change
    Diary.unscoped.all.each do |diary|
      diary.private = false if diary.private != true
      diary.save
    end
  end
end
