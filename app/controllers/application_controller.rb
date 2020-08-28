class ApplicationController < ActionController::Base
  include Mobvious::Rails::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   before_filter :configure_permitted_parameters, if: :devise_controller?
   before_filter :set_locale
   before_filter :set_variables
   #before_filter :first_time_visiting?
   after_filter :clear_notice

   if !Rails.env.development?
    # rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownFormat, with: :render_404
    rescue_from ActionView::MissingTemplate, with: :render_404
  end

  def render_404(exception = env["action_dispatch.exception"])
    if exception
      logger.info "Rendering error - #{status}: #{exception.message}"
      # NewRelic::Agent.notice_error() if status == 500
    end

    response_body || respond_to do |format|
      format.html { render "statics/404", status: 404 }
      format.json { render nothing: true, status: 404 }
      format.rss  { render nothing: true, status: 404 }
      format.xml  { render nothing: true, status: 404 }
      format.jpeg { render nothing: true, status: 404 }
    end and return
  end


    protected

    def first_time_visiting?
      if session[:first_time].nil? then
        session[:first_time] = 1
        redirect_to welcome_path unless current_user
      end
    end

    def clear_notice
      flash[:notice] = ''
      flash[:alert] = ''
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar, :notification_preferences ) }
    end

    private

  def set_variables
    @genre_list = Genre.all
    @country_list = Country.where(is_active?: true)
    @collection_list = Collection.all
    @q = Title.ransack params[:q]
    @last_notification = current_user.user_log_activities.unreaded.order('created_at desc') if current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_admin_locale
    I18n.locale = :en
  end


  def default_url_options(options = {})
    {locale: I18n.locale}
  end
end
