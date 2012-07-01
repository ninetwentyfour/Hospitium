class Admin::NotificationsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /notifications
  # GET /notifications.xml
  def index
    @notifications = Notification.all

    respond_with(@notifications)
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    @notification = Notification.find(params[:id])

    respond_with(@notification)
  end

  # GET /notifications/new
  # GET /notifications/new.xml
  def new
    @notification = Notification.new

    respond_with(@notification)
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.xml
  def create
    @notification = Notification.new(params[:notification])
    if @notification.save
      flash[:notice] = 'Notification was successfully created.'
    else
      flash[:error] = 'Notification was not successfully created.'
    end
    
    respond_with(@notification, :location => admin_notification_path(@notification))
  end

  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    @notification = Notification.find(params[:id])
    @notification.update_attributes(params[:notification])
    
    respond_with(@notification, :location => admin_notification_path(@notification)) 
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    flash[:notice] = 'Successfully destroyed notification.'
    
    respond_with(@notification, :location => admin_notifications_path)
  end
end
