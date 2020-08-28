class App.Utils.CustomRadio

  constructor: ->
    @checkSelected()
    @bindChange()

  checkSelected: ->
    $('.custom-radio').each((index, container)->
      option = $(container).find("[name='"+$(container).data('input') + "']").val()
      $(container).find("[data-value='#{option}']").addClass('selected')
    )

  bindChange: ->  
    $('body').on('click', '.custom-radio a', (event)->
      jEl = $(event.target)
      jParent = jEl.parents('.custom-radio')
      jParent.find('a.selected').removeClass('selected')
      jParent.find("[name='"+jParent.data('input') + "']").val(jEl.data('value'))
      jEl.addClass("selected")
    )
