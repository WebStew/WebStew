Project = WebStew.Project
Technology = WebStew.Technology

class ProjectsFilters extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.loaded
	@include WebStew.ORM.search
	
	el: $ '#projects-filters'
	
	elements:
		'.data-list': 'list'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Technology.bind 'refresh channge', @render
	
	render:  =>
		items = Technology.all()
		@list.empty().prepend @view( 'technologies/filters' )( items )
		@loaded()

class ProjectsResults extends Spine.Controller

	@include WebStew.ORM.loaded
	@include WebStew.ORM.search
	
	el: $ '#projects-results'
	
	elements:
		'.list-search': 'list'
		
	events:
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Project.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
		
	render:  =>
		items = Project.all()
		@list.empty().prepend @view( 'projects/results' )( items )
		@loaded()

class ProjectsIndexes extends Spine.Controller
	
	el: $ '#projects-index'

	constructor: ->
		super
		@filters = new ProjectsFilters
		@results = new ProjectsResults
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'

class ProjectsDetails extends Spine.Controller
	
	el: $ '#projects-details'

	constructor: ->
		super
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
		
class WebStew.Projects extends Spine.Stack

	el: $ '#projects'

	controllers:
		index: ProjectsIndexes
		detail: ProjectsDetails
	
	default: 'index'
	
	constructor: ->
		super
		Project.fetch()
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'