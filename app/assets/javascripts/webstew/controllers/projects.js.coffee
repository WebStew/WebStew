class WebStew.Projects extends Spine.Controller

	el: $ '#projects'
	
	className: 'stack-item'
	
	constructor: ->
		super
		@log 'Project controller init'
	
	deactivate: ->
		@log 'Projects inative'
		@el.removeClass 'active'
	
	activate: ->
	
		@el.addClass 'active'
		@html @view 'projects/index'
		@log 'Projects active'