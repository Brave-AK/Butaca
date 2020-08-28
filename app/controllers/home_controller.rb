class HomeController < ApplicationController
  add_breadcrumb I18n.t('home'), :root_path
  skip_before_filter :first_time_visiting?, only: [:landing_page]

  def index
    @collections = Collection.all
    @featured_collection = Collection.featured
  end

  def landing_page
    render layout: false
  end

  def about
  end
end
