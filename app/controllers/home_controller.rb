class HomeController < ApplicationController
  def index
    @diaries = Diary.order_time.all
  end

  def about
  end
end
