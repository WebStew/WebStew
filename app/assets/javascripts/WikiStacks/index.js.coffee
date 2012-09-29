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
class WikiStacks extends Spine.Stack

	el: $ '#wiki-stacks'

	elements:
		'.page-name .section-name': 'section'
		'.webstew-nav': 'nav'
	
	routes:
		'/home': ( route ) ->
			@stacks.deactivate()
			@contacts.deactivate()
			@updateHeader route
			@homes.activate()
			
		'/stacks/projects/view/:id': ( route ) ->		
			@homes.deactivate()
			@contacts.deactivate()
			@stacks.projects.active()
			@stacks.projects.details.active route.id.match( /\?id=(.*)/ )[ 1 ]
			@updateHeader route
			@stacks.activate()
			
		'/stacks/projects': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@stacks.projects.active()
			@stacks.projects.index.active()
			@updateHeader route
			@stacks.activate()
			
		'/stacks/technologies/view/:id': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@stacks.technologies.active()
			@stacks.technologies.details.active route.id.match( /\?id=(.*)/ )[ 1 ]
			@updateHeader route
			@stacks.activate()
			
		'/stacks/technologies': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@stacks.technologies.active()
			@stacks.technologies.index.active()
			@updateHeader route
			@stacks.activate()
			
		'/stacks': ( route ) ->
			@homes.deactivate()
			@contacts.deactivate()
			@updateHeader route
			@stacks.activate()
		
		'/contact-us': ( route ) ->
			@stacks.deactivate()
			@homes.deactivate()
			@updateHeader route
			@contacts.activate()
	
	constructor: ->
		super
		
		# Overwrite the default spine isActive function
		Spine.Controller.include WikiStacks.ORM.state
				
		console.log(@active);
		
		class Contacts extends Spine.Controller
		
			el: $ '#contacts'

			constructor: ->
				super
		
		class Homes extends Spine.Controller
		
			el: $ '#homes'

			constructor: ->
				super
		
		class Stacks extends Spine.Stack

			controllers:
				projects: WikiStacks.Projects
				technologies: WikiStacks.Technologies
				
			default: 'projects'
		
			el: $ '#stacks'
			
			classNames: 'stack-manager stack-item'

			elements:
				'> .stack-nav': 'nav'

			constructor: ->
				super
			
			activate: ->
				@el.addClass 'stack-item-active'
				@updateNav()
			
			updateNav: () ->
				location = if @projects.isActive() then '/stacks/projects' else '/stacks/technologies'
				@nav.find( '.button-secondary-pressed' ).addClass( 'button-secondary' ).removeClass 'button-secondary-pressed'
				@nav.find( 'a[href="#' + location + '"]' ).addClass( 'button-secondary-pressed' ).removeClass 'button-secondary'

		@stacks = new Stacks
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
		location = WikiStacks.utilities.upperCaseFirst paths[ paths.length - 1 ].replace '-', ' '
		location = location.replace /\?(.*)/, ''
		
		# Update the section names and page title
		@section.text location
		$('title').text 'WikiStacks - ' + location
		
		# Update thenavigation
		@nav.find( '.stack-nav-active' ).removeClass 'stack-nav-active'
		@nav.find( 'a[href="#/' + section + '"]' ).addClass 'stack-nav-active'
		

window.WikiStacks = WikiStacks

jQuery ($) ->
	new WikiStacks