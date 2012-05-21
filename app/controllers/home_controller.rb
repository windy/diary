class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>[:about, :index]
  def index
    @diaries = Diary.displayer.order_time.all
  end

  def about
  end
end
