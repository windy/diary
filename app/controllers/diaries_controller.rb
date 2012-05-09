class DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end

  def index
    @diaries = current_user.diaries.order_time
  end

  def create
    @diary = Diary.new(params[:diary])
    current_user.diaries << @diary
    if current_user.save
      flash[:notice] = t(:success)
      redirect_to :action=>:index
    else
      render :action=> :new
    end
  end

  def update
  end

  def destroy
  end

  def show
    @diary = current_user.diaries.find(params[:id])
    text = @diary.text
    text = BlueCloth.new(text).to_html unless params[:origin]
    render :text=>@diary.text
  end

  def preview
    text = params[:text]
    render :text=> BlueCloth.new(text).to_html
  end

  def edit
  end
end
