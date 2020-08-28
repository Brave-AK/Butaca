class App.Utils.SidebarMenu

  constructor: ->
    @_initCollapsing()
    @_initArrowsRotation()

  _initCollapsing: ->
    $('.sidebarr .collapse-a').on('click', (event)->
      event.preventDefault()
      jToggledList = $($(@).attr('href'))
      jToggledList.collapse('toggle')
    )

  _initArrowsRotation: ->
    $('.sidebarr ul.collapse').on('show.bs.collapse', ->
      $(@).siblings('.list-header').find('.fa').removeClass('fa-angle-right').addClass('fa-angle-down');
    )

    $('.sidebarr ul.collapse').on('hidden.bs.collapse', ->
      $(@).siblings('.list-header').find('.fa').removeClass('fa-angle-down').addClass('fa-angle-right');
    )
