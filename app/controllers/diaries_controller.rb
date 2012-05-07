class DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end

  def index
    @diaries = current_user.diaries
  end

  def create
    @diary = Diary.new(params[:diary])
    current_user.diaries << @diary
    if current_user.save
      flash[:notice] = "success!"
      redirect_to :action=>:index
    end
  end

  def update
  end

  def destroy
  end

  def show
    @diary = current_user.diaries.find(params[:id])
    render :text=>@diary.text
  end

  def edit
  end
end
