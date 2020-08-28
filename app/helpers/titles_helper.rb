module TitlesHelper

  class TitleLinkBuilder
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::TranslationHelper

    def initialize(user, title, options = {})
      @user = user
      @title = title
      @options = options
    end

    def id
    end

    def path
      if @user
        '#'
      else
        Rails.application.routes.url_helpers.new_user_registration_path(feature: true)
      end
    end

    def classes
      ['btn', 'uk-button', 'add_favourite', 'btn-action-title']
    end

    def content
      ''
    end

    def html_options
      {class: classes.join(' '), id: id}
    end

    def call
      link_to content, path, html_options
    end
  end

  class FavoritesLink < TitleLinkBuilder
    def id
      "add-to-favorite-#{@title.id}"
    end

    def content
      if @options[:detailed_view]
        t('add_to_favorite')
      else
        ''
      end
    end

    def classes
      if @user && @user.favorited_title?(@title)
        super + ['selected', 'btn-like']
      else
        super + ['btn-like']
      end
    end

    def html_options
      super.merge({:onclick => "return App.Titles.addToFav(#{@title.id})",
       :data => {:toggle=>"tooltip",
       :placement=>"left",
       :title=>"#{t('add_to_favorite')}",
       :id=>"add-to-favorite-#{@title.id}"
      }})
    end
  end

  class RemoveLink < TitleLinkBuilder
    def id
      "remove-film-#{@title.id}"
    end

    def content
      if @options[:detailed_view]
        t('remove_from_view')
      else
        ''
      end
    end

    def classes
      super + ['btn-remove']
    end

    def html_options
      super.merge({:onclick => "return App.Titles.removeFromView(#{@title.id})",
                    :data => {:toggle=>"tooltip",
                              :placement=>"left",
                              :title=>"#{t('remove_from_view')}"
                              }
                    })
    end

  end


  class AddToQueueLink < TitleLinkBuilder
    def id
      "add-to-queue-#{@title.id}"
    end

    def content
      if @options[:detailed_view]
        t('add_to_queue')
      else
        ''
      end
    end

    def classes
      if @user && @user.queued_title?(@title)
        super + ['selected', 'btn-queue']
      else
        super + ['btn-queue']
      end
    end

    def html_options
      super.merge({:onclick => "return App.Titles.addToQueue(#{@title.id})",
                   :data => {:toggle=>"tooltip",
                              :placement=>"left",
                              :title=>"#{t('add_to_queue')}",
                              :id=>"add-to-queue-#{@title.id}"
                              }
                    })
    end

  end

  class ShowDetailsLink < TitleLinkBuilder
    def path
      Rails.application.routes.url_helpers.title_path(id: @title.id, locale: I18n.locale)
    end

    def id
      "show-title-#{@title.id}"
    end

    def content
      ''
    end

    def classes
      super + ['btn-eye']
    end

    def html_options
      super.merge({:remote=> true,
                    :data => {:toggle=>"tooltip",
                              :placement=>"left"
                              }
                    })
    end

  end

  def add_to_favorites_link(user, title, options = {})
    FavoritesLink.new(user, title, options).call
  end

  def remove_link(user, title, options = {})
    RemoveLink.new(user, title, options).call
  end

  def add_to_queue_link(user, title, options = {})
    AddToQueueLink.new(user, title, options).call
  end


  def show_details_link(user, title, options = {})
    ShowDetailsLink.new(user, title, options).call
  end

  def report_problem_link(user, title, options = {})
  end

  # we display details page for title
  def details_page?
    @title_details_page || controller?('titles') && action?('show')
  end


end
