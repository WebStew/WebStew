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
	
	constructor: ->
		super
		
		class SidebarStack extends Spine.Stack
		
			el: $ '#sidebar'
			
			className: 'stack-manager'
			
			elements: 
				'.stack-nav': 'nav'
			
			constructor: ->
				super
				@navigate '/projects'
			
			controllers:
				projects: WebStew.Projects
				technologies: WebStew.Technologies
					
			routes:
				'/technologies': (route) ->
					@updateNav route.match.input
					@technologies.active()
					
				'/projects':  (route) ->
					@updateNav route.match.input
					@projects.active()
				
			updateNav: (location) ->
				@nav.find('.button-secondary-pressed').addClass('button-secondary').removeClass 'button-secondary-pressed'
				@nav.find('a[href="#' + location + '"]').addClass('button-secondary-pressed').removeClass 'button-secondary'
			
			activate: ->
				@el.addClass 'stack-active'
				
			deactivate: ->
				@el.removeClass 'stack-active'
				
		@sidebar = new SidebarStack
		
		Spine.Route.setup()
		
window.WebStew = WebStew

jQuery ($) ->
	new WebStew()