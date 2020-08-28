module CollectionsHelper

	def follow_button_class(user, collection)
		default_class = "addCollection follow_btn follow-button-#{collection.slug}"
		follow_state = if user && user.follow_collection?(collection.id)
							'followed '
						else
							'follow'
						end
		"#{follow_state} #{default_class}"				
	end

	def follow_button_text(user, collection)
		if user.follow_collection?(collection.id)
			t('followed')
		else
			t('follow')
		end
	end
end