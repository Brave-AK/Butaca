class UsersController < ApplicationController

  before_filter :set_user, only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def followed_collections
    @collections = current_user.followed_collections
  end

  def add_a_film
    current_user.film_requests.create(film_request_params)
    # redirect_to(root_path, :notice => "Your message sent to administrator")
  end

  def my_profile
    if show_profile_part?('favorites')
      @favorites = current_user.user_favorites.includes(:title)
    end
    if show_profile_part?('queue')
      @queues = current_user.user_queues.includes(:title)
    end
    if show_profile_part?('removals')
      @user_removals = current_user.user_removals.includes(:title)
    end
  end

  def settings

  end

  def update
    updated = if user_params[:password].present?
      current_user.update_attributes(user_params)
    else
      current_user.update_without_password(user_params.except(:password, :password_confirmation))
    end
    if updated
      sign_in @user, :bypass => true if user_params[:password].present?
      redirect_to :my_profile
    else
      render :settings
    end

  end

  def upload_avatar
    current_user.avatar = params[:avatar]
    current_user.save
    render json: {success: true}
  end

  private

    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name,
                                   :country_id, :bio, :password,
                                   :password_confirmation, :notification_preferences )
    end

    def film_request_params
      params.require(:add_a_film).permit(:approximate_year, :comment, :film_name)
    end


    def show_profile_part?(part_name)
      !params[:part] || params[:part] == part_name
    end

    helper_method :show_profile_part?


end
