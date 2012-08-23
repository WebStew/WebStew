#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route
#= require spine/manager
#= require spine/list

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class WebStew extends Spine.Controller

	el: $ '#webstew'
	
	constructor: ->
		super
		@log 'Webstew init'
		
		@stack = new Spine.Stack
			el : 'webstew-stack'
			className: 'stack-manager'
			controllers:
				projects: WebStew.Projects
				technologies: WebStew.Technologies
		
		Spine.Route.setup()
		
window.WebStew = WebStew

jQuery ($) ->
	new WebStew()