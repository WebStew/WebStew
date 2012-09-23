Project = WebStew.Project

class ProjectsIndex extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	
	el: $ '#projects-index'
	
	className: 'stack-item'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'

	constructor: ->
		super
		Project.fetch()
		Project.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
	
	render:  =>
		items = Project.all()
		@html @view('projects/index')(items)
		
class WebStew.Projects extends Spine.Stack
	constructor: ->
		super
		@index.active()

	el: $ '#projects'
	
	className: 'stack-manager stack-item'

	controllers:
		index: ProjectsIndex
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'