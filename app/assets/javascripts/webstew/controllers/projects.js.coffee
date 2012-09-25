Project = WebStew.Project

class ProjectsSidebars extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	
	el: $ '#projects-sidebars'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Project.bind 'refresh channge', @render
	
	render:  =>
		items = Project.all()
		@html @view('projects/sidebar')(items)

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