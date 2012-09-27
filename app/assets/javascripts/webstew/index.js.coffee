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
			@updateHeader route
			@homes.activate()
			
		'/experience/projects/view/:id': ( route ) ->		
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.projects.active()
			@experiences.projects.detail.active route.id.match( /\?id=(.*)/ )[ 1 ]
			@experiences.updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/projects': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.projects.active()
			@experiences.projects.index.active()
			@experiences.updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/technologies/view/:id': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.technologies.active()
			@experiences.technologies.detail.active route.id.match( /\?id=(.*)/ )[ 1 ]
			@experiences.updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience/technologies': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.technologies.active()
			@experiences.technologies.index.active()
			@experiences.updateNav route
			@updateHeader route
			@experiences.activate()
			
		'/experience': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@experiences.projects.index.active()
			@experiences.projects.active()
			@updateHeader route
			@experiences.updateNav route
			@experiences.activate()
		
		'/contact-me': ( route ) ->
			@experiences.deactivate()
			@homes.deactivate()
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
	
	updateHeader: ( route ) ->
		paths = route.match.input.split '/'
		section = paths[ 1 ]
		location = WebStew.utilities.upperCaseFirst paths[ paths.length - 1 ].replace '-', ' '
		location = location.replace /\?(.*)/, ''
		
		# Update the section names and page title
		@section.text location
		$('title').text 'WebStew - ' + location
		
		# Update thenavigation
		@nav.find( '.stack-nav-active' ).removeClass 'stack-nav-active'
		@nav.find( 'a[href="#/' + section + '"]' ).addClass 'stack-nav-active'
		

window.WebStew = WebStew

jQuery ($) ->
	new WebStew