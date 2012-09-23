Technology = WebStew.Technology

class TechnologiesIndex extends Spine.Controller

	@include WebStew.ORM.checkbox
	@include WebStew.ORM.search
	
	el: $ '#technologies-index'
	
	className: 'stack-item'
	
	events:
		'click label': 'toggleCheckbox'

	constructor: ->
		super
		Technology.fetch()
		Technology.bind 'refresh channge', @render
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
	
	render:  =>
		items = Technology.all()
		@html @view('technologies/index')(items)
		
class WebStew.Technologies extends Spine.Stack

	el: $ '#technologies'
	
	className: 'stack-manager stack-item'
	
	constructor: ->
		super
		@index.active()

	controllers:
		index: TechnologiesIndex
	
	activate: ->
		@el.addClass 'stack-item-active'
		
	deactivate: ->
		@el.removeClass 'stack-item-active'
