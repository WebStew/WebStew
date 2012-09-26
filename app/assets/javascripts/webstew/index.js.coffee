#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route
#= require spine/manager

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

	elements:
		'.page-name .section-name': 'section'
		'.webstew-nav': 'nav'
	
	routes:
		'/home': ( route ) ->
			@experiences.deactivate()
			@contacts.deactivate()
			@updateNav route
			@updateHeader route
			@homes.activate()
			
		'/experience/projects/:id': ( route ) ->
			console.log(route);
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.projects.active()
			@experiences.projects.detail.active()
			@experiences.updateNav route
			@updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/projects': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.projects.active()
			@experiences.projects.index.active()
			@experiences.updateNav route
			@updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/technologies/:id': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.technologies.active()
			@experiences.technologies.detail.active()
			@experiences.updateNav route
			@updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/technologies': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.technologies.active()
			@experiences.technologies.index.active()
			@experiences.updateNav route
			@updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			#@experiences.projects.deactivate()
			#@experiences.technologies.deactivate()
			@updateNav route
			@updateHeader route
			@experiences.updateNav route
			@experiences.activate()
		
		'/contact-me': ( route ) ->
			@experiences.deactivate()
			@homes.deactivate()
			@updateNav route
			@updateHeader route
			@contacts.activate()
	
	constructor: ->
		super
		
		class Contacts extends Spine.Controller
		
			el: $ '#contacts'

			constructor: ->
				super

			activate: ->
				@el.addClass 'stack-item-active'

			deactivate: ->
				@el.removeClass 'stack-item-active'
		
		class Homes extends Spine.Controller
		
			el: $ '#homes'

			constructor: ->
				super

			activate: ->
				@el.addClass 'stack-item-active'

			deactivate: ->
				@el.removeClass 'stack-item-active'
		
		class Experiences extends Spine.Stack
		
			el: $ '#experiences'

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
			
			updateNav: ( route ) ->
				location = if route.match.input is '/experience' then '/experience/projects' else route.match.input
				@nav.find( '.button-secondary-pressed' ).addClass( 'button-secondary' ).removeClass 'button-secondary-pressed'
				@nav.find( 'a[href="#' + location + '"]' ).addClass( 'button-secondary-pressed' ).removeClass 'button-secondary'

		@experiences = new Experiences
		@homes = new Homes
		@contacts = new Contacts
		
		if !window.location.hash
			@navigate '/home'
		
		Spine.Route.setup
			history: true
		
		@loaded()
	
	loaded: ->
		@el.children( '.image-loading' ).remove()
		@el.removeClass 'controller-loading'
	
	updateNav: ( route ) ->
		location = route.match.input.split( '/' )[ 1 ]
		@nav.find( '.stack-nav-active' ).removeClass 'stack-nav-active'
		@nav.find( 'a[href="#/' + location + '"]' ).addClass 'stack-nav-active'
	
	updateHeader: ( route ) ->
		location = route.match.input.split '/'
		location = WebStew.utilities.upperCaseFirst location[ location.length - 1 ].replace '-', ' '
		@section.text location
		$('title').text 'WebStew - ' + location
		

window.WebStew = WebStew

jQuery ($) ->
	new WebStew