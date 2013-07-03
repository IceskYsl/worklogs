class WorklogsController < ApplicationController
  model_object Worklog
  unloadable
  before_filter :find_model_object, :except => [:index, :new, :create,:my]
  before_filter :init_slider,:only => [:index, :my]
  
  
  def init_slider
    @last=Worklog.find(:first,:order =>"created_at asc").created_at.to_date if Worklog.count > 0
    @last ||= Date.today
    # @last = Date.new(@start_topic.year,@start_topic.mon,1)
    @start=Date.today
    scope = User.logged.status(1).where("id > 1")
    @users =  scope.order("last_login_on desc").all
  end
  
  def load_worklogs
    worklogs_scope = Worklog.where("status = 0")
    if @user_id && @user_id.to_i > 0
      worklogs_scope = worklogs_scope.where(:user_id => @user_id)
    end
    
    unless @day.blank?
      worklogs_scope = worklogs_scope.where(:day => @day)
    end
    
    @worklogs =  worklogs_scope.order("day desc,id desc").all
  end
  

  def index
    @user_id = params[:user_id]
    @day = params[:day]
    load_worklogs
  end
  
  def my
    @user_id = session[:user_id]
    @day = params[:day]
    load_worklogs
    render :action => :index
  end

  def new
    @day = Date.today
    @worklog = Worklog.new()
  end
  
  def edit
    @day = Date.today
  end
  
  def update
    # @worklog.safe_attributes = params[:worklog]
    @worklog.update_attributes(params[:worklog])
    if request.put? and @worklog.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to worklogs_path()
    else
      render :action => 'edit',:id=>@worklog.id
    end
  end
  
  def create
    @worklog = Worklog.new(params[:worklog])
    @worklog.day = Date.today
    @worklog.author = User.current
    @worklog.save
    redirect_to worklogs_path()
  end


end
