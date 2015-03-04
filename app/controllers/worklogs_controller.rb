#encoding: utf-8
class WorklogsController < ApplicationController
  model_object Worklog
  unloadable

  # before_filter :authorize, :only => [:index,:my,:new]
  
  before_filter :find_model_object, :except => [:index, :new, :create,:my,:preview]
  before_filter :init_slider,:only => [:index, :my, :new, :edit, :show]
  
  
  def init_slider
    @last=Worklog.find(:first,:order =>"created_at asc").created_at.to_date if Worklog.count > 0
    @last ||= Date.today
    # @last = Date.new(@start_topic.year,@start_topic.mon,1)
    @start=Date.today
    scope = User.logged.status(1)
    @users =  scope.order("id asc").all - Worklog.no_need_users
  end
  
  def load_worklogs
    worklogs_scope = Worklog.where("status = 0")
    if @user_id && @user_id.to_i > 0
      worklogs_scope = worklogs_scope.where(:user_id => @user_id)
    end
    
    unless @week.blank?
      worklogs_scope = worklogs_scope.where(:week => @week)
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
    @week = params[:week]
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
    @week = params[:week]
    load_worklogs
    render :action => :index
  end

  def new
    @day = Date.today
    @day_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,0).last
    @week_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,1).last
    @month_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,2).last
    @year_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,3).last
    
    # @wl = Worklog.where("user_id = ? and day = ?",session[:user_id],@day).first
    # if @wl
    #   redirect_to :action => 'edit',:id=> @wl.id
    # else
    #   @worklog = Worklog.new()      
    # end
    @worklog = Worklog.new()    
    @worklog.typee = 1  
  end
  
  
  def edit
    @day = Date.today
    @day_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,0).last
    @week_todo = Worklog.where("user_id = ? and day <> ? and typee = ?", session[:user_id],Date.today,1).last

  end

  def show
    @worklog_reviews = @worklog.worklog_reviews
    @worklog_review = WorklogReview.new()
  end
  

  def review
    @worklog_reviews = WorklogReview.new(params[:worklog_review])
    @worklog_reviews.user = User.current
    @worklog_reviews.worklog = @worklog
    if @worklog_reviews.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to worklog_path(:id=>@worklog.id)
    end
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
    @worklog.month = Date.today.strftime("%m").to_i
    @worklog.year = Date.today.strftime("%Y").to_i
    @worklog.author = User.current
    if @worklog.save
      redirect_to worklogs_path()
    else
    end
    
  end


end
