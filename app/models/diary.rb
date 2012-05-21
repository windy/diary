class Diary < ActiveRecord::Base
  attr_accessible :name, :text, :private
  
  validates :name, :presence=> true, :uniqueness=> { :scope=> :user_id }

  scope :order_time, order("created_at DESC")

  scope :displayer, where(:private => false)

  belongs_to :user

  def markdown_text
    BlueCloth.new(text).to_html
  end
end
