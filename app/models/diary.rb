class Diary < ActiveRecord::Base
  attr_accessible :name, :text
  
  validates :name, :presence=> true, :uniqueness=> { :scope=> :user_id }

  scope :order_time, order("created_at DESC")

  def markdown_text
    BlueCloth.new(text).to_html
  end
end
