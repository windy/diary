class DiariesController < ApplicationController
  def new
    @diary = Diary.new
    if current_user.saved
      @diary.text = current_user.saved
      flash[:notice] = t(:last_diary_exist_message)
    end
  end

  def index
    @diaries = current_user.diaries.order_time
  end

  def user_index
    user = User.find_by_name(params[:user])
    @diaries = user.diaries.order_time
    render :index
  end

  def create
    @diary = Diary.new(params[:diary])
    current_user.diaries << @diary
    if current_user.save
      current_user.saved = nil
      current_user.save
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
    #@diary = current_user.diaries.find(params[:id])
    @diary = Diary.find(params[:id])
    text = @diary.text
    text = @diary.markdown_text unless params[:origin]
    render :text=>text
  end

  def preview
    text = params[:text]
    render :text=> BlueCloth.new(text).to_html
  end

  def edit
  end
  
  def save
    text = params[:text]
    current_user.saved = text
    if current_user.save
      render :text=>true
    else
      logger.warn("save log error: #{ current_user.errors.message.to_s }")
      render :text=>false
    end
  end
end
