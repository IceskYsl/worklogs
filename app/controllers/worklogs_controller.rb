#encoding: utf-8
class WorklogsController < ApplicationController
  model_object Worklog
  unloadable

  # before_filter :authorize, :only => [:index,:my,:new]
  
  before_filter :find_model_object, :except => [:index, :new, :create,:my,:preview]
  before_filter :init_slider,:only => [:index, :my, :new, :edit]
  
  
  def init_slider
    @last=Worklog.find(:first,:order =>"created_at asc").created_at.to_date if Worklog.count > 0
    @last ||= Date.today
    # @last = Date.new(@start_topic.year,@start_topic.mon,1)
    @start=Date.today
    scope = User.logged.status(1)
    @users =  scope.order("last_login_on desc").all - Worklog.no_need_users
  end
  
  def load_worklogs
    worklogs_scope = Worklog.where("status = 0")
    if @user_id && @user_id.to_i > 0
      worklogs_scope = worklogs_scope.where(:user_id => @user_id)
    end
    
    unless @day.blank?
      worklogs_scope = worklogs_scope.where(:day => @day)
    end
    
    unless @typee.blank?
      worklogs_scope = worklogs_scope.where(:typee => @typee)
    end
    
    worklogs_scope = worklogs_scope.order("day desc,id desc")
    @limit =  Setting.plugin_worklogs['WORKLOGS_PAGINATION_LIMIT'].to_i || 20
    # @worklogs = worklogs_scope.all#.limit(@limit)
    
    @worklogs_count = worklogs_scope.count
    @worklogs_pages = Paginator.new @worklogs_count, @limit, params['page']
    @offset ||= @worklogs_pages.offset
    @worklogs = worklogs_scope.all(    :order => "#{Worklog.table_name}.created_at DESC",
                                       :offset => @offset,
                                       :limit => @limit)
  end
  

  def index
    @user_id = params[:user_id]
    @day = params[:day]
    @typee = params[:typee]
    load_worklogs
  end
  
  def preview
    # logger.info(params[:worklog])
    
    if params[:id].present? && worklog = Worklog.visible.find_by_id(params[:id])
      @previewed = worklog
    end
    # @text = (params[:worklog] ? params[:worklog][:do] : nil)
    @worklog = Worklog.new(params[:worklog])
    @worklog.day = Date.today
    @worklog.week = Date.today.strftime("%W").to_i
    @worklog.author = User.current
    render :partial => 'preview'
  end
  

  
  def my
    @user_id = session[:user_id]
    @day = params[:day]
    load_worklogs
    
    render :action => :index
  end

  def new
    @day = Date.today
    # @wl = Worklog.where("user_id = ? and day = ?",session[:user_id],@day).first
    # if @wl
    #   redirect_to :action => 'edit',:id=> @wl.id
    # else
    #   @worklog = Worklog.new()      
    # end
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
    @worklog.week = Date.today.strftime("%W").to_i
    @worklog.author = User.current
    @worklog.save
    redirect_to worklogs_path()
  end


end
