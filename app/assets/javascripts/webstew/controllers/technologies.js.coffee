Project = WebStew.Project
Technology = WebStew.Technology

class TechnologiesFilters extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	@include WebStew.ORM.loaded
	
	el: $ '#technologies-filters'
	
	elements:
		'.data-list': 'list'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Project.bind 'refresh channge', @render
	
	render:  =>
		items = Project.all()
		@list.empty().prepend @view('projects/filters')(items)
		@loaded()
		
class TechnologiesResults extends Spine.Controller

	@include WebStew.ORM.loaded

	el: $ '#technologies-results'
	
	elements:
		'.list-search': 'list'
	
	constructor: ->
		super
		Technology.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
	
	render:  =>
		items = Technology.all()
		@list.empty().prepend @view('technologies/results')(items)
		@loaded()
	
class TechnologiesIndexes extends Spine.Controller

	el: $ '#technologies-index'
	
	constructor: ->
		super
		@sidebar = new TechnologiesFilters
		@results = new TechnologiesResults
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
		
class WebStew.Technologies extends Spine.Stack

	el: $ '#technologies'

	controllers:
		index: TechnologiesIndexes
	
	constructor: ->
		super
		Technology.fetch()
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
