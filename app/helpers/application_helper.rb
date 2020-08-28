module ApplicationHelper
  include Mobvious::Rails::Helper

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def pageless(total_pages, url=nil, container=nil)
    opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderMsg  => 'Loading more...',
        :loaderImage => image_path('loading-small.gif')
    }

    container && opts[:container] ||= container

    javascript_tag("$('#{container}').pageless(#{opts.to_json});")
  end

end
