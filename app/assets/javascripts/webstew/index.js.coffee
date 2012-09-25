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
class WebStew extends Spine.Stack

	el: $ '#webstew'
	
	className: 'stack-manager'
	
	routes:		
		'/home/projects': (route) ->
			@homes.projects.active()
			@homes.activate()
			@homes.updateNav route
		'/home/technologies': (route) ->
			@homes.technologies.active()
			@homes.activate()
			@homes.updateNav route
		'/home': (route) ->
			@homes.activate()
	
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

			default: 'projects'

			constructor: ->
				super

			activate: ->
				@el.addClass 'stack-item-active'

			deactivate: ->
				@el.removeClass 'stack-item-active'
			
			updateNav: (route) ->
				@nav.find('.button-secondary-pressed').addClass('button-secondary').removeClass 'button-secondary-pressed'
				@nav.find('a[href="#' + route.match.input + '"]').addClass('button-secondary-pressed').removeClass 'button-secondary'

		@homes = new Homes
		
		if !window.location.hash
			@navigate '/home'
		
		Spine.Route.setup
			history: true
		
		@loaded()
	
	loaded: ->
		@el.children('.image-loading').remove()
		@el.removeClass 'controller-loading'
		
window.WebStew = WebStew

jQuery ($) ->
	new WebStew