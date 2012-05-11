class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>[:about]
  def index
    @diaries = Diary.order_time.all
  end

  def about
  end
end
