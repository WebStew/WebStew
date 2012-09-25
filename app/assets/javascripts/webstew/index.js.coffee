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
#= require ./config
#= require ./utilities
#= require ./orm
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

# Application namespace
class WebStew extends Spine.Controller

	el: $ '#webstew'
	
#	className: 'stack-manager'
# 	
# 	controllers:
# 		homes: Homes
	
# 	routes:
# 		'/home': (route) ->
# 			@homes.active()
	
	constructor: ->
		super
		
		class Homes extends Spine.Stack
		
			el: $ '#homes'
			
			className: 'stack-manager stack-item'

			elements: 
				'> .stack-nav': 'nav'

			controllers:
				projects: WebStew.Projects
				technologies: WebStew.Technologies

			routes:
				'/home/projects': (route) ->
					@projects.active()
				'/home/technologies': (route) ->
					@technologies.active()

			constructor: ->
				super
				#@projects.active()

			activate: (x) ->
				@el.addClass 'stack-item-active'
				console.log(x);
				#@nav.find('.button-secondary-pressed').addClass('button-secondary').removeClass 'button-secondary-pressed'
				#@nav.find('a[href="#' + location + '"]').addClass('button-secondary-pressed').removeClass 'button-secondary'

			deactivate: ->
				@el.removeClass 'stack-item-active'

		@homes = new Homes
		console.log(@homes);
		@homes.active()
		
# 		if !window.location.hash
# 			@navigate '/home'
		
		Spine.Route.setup()
		
window.WebStew = WebStew

jQuery ($) ->
	new WebStew