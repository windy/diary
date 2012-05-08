class Diary < ActiveRecord::Base
  attr_accessible :name, :text
  scope :order_time, order("created_at DESC")
end
