Technology = WebStew.Technology

class TechnologiesIndex extends Spine.Controller
	
	el: $ '#technologies-index'
	
	className: 'stack-item'

	constructor: ->
		super
		Technology.fetch()
		Technology.bind 'refresh channge', @render
	
	activate: ->
		@log 'Technologies index activated'
	
	render:  =>
		items = Technology.all()
		@html @view('technologies/index')(items)
		
class TechnologiesStack extends Spine.Stack

	el: 'technologies-stack'
	
	className: 'stack-manager'

	controllers:
		index: TechnologiesIndex

class WebStew.Technologies extends Spine.Controller

	el: $ '#technologies'
	
	className: 'stack-item'
	
	constructor: ->
		super
		@log 'Technolgies top tier controller init'
		@stack = new TechnologiesStack
		
		@routes
			'/technologies': @navigateIndex
	
	navigateIndex: ->
		@log 'Activating Technolgies index controller'
		@stack.index.active()
		
	
	deactivate: ->
		@el.removeClass 'active'
		@log 'Technologies inactive'
	
	
	activate: ->
		@el.addClass 'active'
		@log 'Technologies active'
  		
  		