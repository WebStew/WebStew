Technology = WebStew.Technology

class TechnologiesSidebars extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	
	el: $ '#technologies-sidebars'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Technology.bind 'refresh channge', @render
	
	render:  =>
		items = Technology.all()
		@html @view('technologies/sidebar')(items)
		
class TechnologiesResults extends Spine.Controller

	el: $ '#technologies-results'
	
	className: 'stack-item'
	
	constructor: ->
		super
		@sidebar = new TechnologiesSidebars
		Technology.fetch()
		#Technology.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
		
class WebStew.Technologies extends Spine.Stack

	el: $ '#technologies'
	
	className: 'stack-manager stack-item'

	controllers:
		results: TechnologiesResults
	
	constructor: ->
		super
		@results.active()
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
