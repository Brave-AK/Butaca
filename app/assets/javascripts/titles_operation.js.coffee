class App.Titles


	# TODO:a.filipko add  get 'user_removals/add/:title_id' => 'user_removals#add', as: :add_to_removal
	@addToFav: (id)->
		$("[data-id='#add-to-favorite-#{id}']").toggleClass('selected')
		@_sendGetRequest('/user_favorites/add/:title_id', {title_id: id})

	@addToQueue: (id)->	
		$("[data-id='aadd-to-queue-#{id}']").toggleClass('selected')
		@_sendGetRequest('/user_queues/add/:title_id', {title_id: id})

	@removeFromView: (id)->
		$("#confirmation-modal-uniq .confirm-button").off('click')
		$("#confirmation-modal-uniq .cancel-button").off('click')

		$("#confirmation-modal-uniq").modal('show')
		$("#confirmation-modal-uniq .confirm-button").on('click', (e)=>
			@_sendGetRequest('/user_removals/add/:title_id', {title_id: id})
			$("#confirmation-modal-uniq").modal('hide')
		)
		$("#confirmation-modal-uniq .cancel-button").on('click', (e)=>
			$("#confirmation-modal-uniq").modal('hide')
		)

	# Send get request with params in URL
	# 
	# @path template string /asfa/:param1/:param2
	# options Object template_key => value
	@_sendGetRequest: (path, options)->
		requestPath = path
		$.each(options, (key,value)-> path = path.replace(":#{key}", value))
		$.get(path)
