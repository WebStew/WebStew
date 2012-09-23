WebStew.ORM = {

	# Toggles the data-active class on a checked/unchecked checkbox
	checkbox:
		toggleCheckbox: (e) ->
		
			label = $ e.currentTarget
			
			if label.prev('input').is ':checked'
				label.removeClass 'data-active'
				
			else
				label.addClass 'data-active'
	
	# Search through the controller data list and hides or shows the children depending on the filter value
	search:
		filter: (e) ->
			
			e.preventDefault();
			
			filter = @.el.find('.data-search-input').val()
			list = @.el.find '.data-list'
			
			if filter
				list.find('li:not(:Contains(' + filter + '))').hide();
				list.find('li:Contains(' + filter + ')').show();
			
			else
				list.children().show();
}