class CountriesController < ApplicationController
  add_breadcrumb I18n.t('home'), :root_path
  add_breadcrumb I18n.t('countries'), :countries_path

  # GET /countrytitles
  def index
    @countries = Country.where(is_active?: true)
  end

  # GET /countrytitles/1
  def show
    @country = Country.friendly.find(params[:id])
    @titles = (@country.titles.order_by_position-Title.in_removals(current_user)).paginate(page: params[:page], per_page: 30)
    add_breadcrumb @country.country, country_path(@country)
    if request.xhr?
       
      render :partial => @titles
    end
  end





end
