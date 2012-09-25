Project = WebStew.Project

class ProjectsSidebars extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	@include WebStew.ORM.loaded
	
	el: $ '#projects-sidebars'
	
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
		@list.empty().prepend @view('projects/sidebar')(items)
		@loaded()

class ProjectsResults extends Spine.Controller
	
	el: $ '#projects-results'
	
	className: 'stack-item'

	constructor: ->
		super
		@sidebar = new ProjectsSidebars
		Project.fetch()
		#Project.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
		
class WebStew.Projects extends Spine.Stack

	el: $ '#projects'
	
	className: 'stack-manager stack-item'

	controllers:
		results: ProjectsResults
	
	constructor: ->
		super
		@results.active()
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'