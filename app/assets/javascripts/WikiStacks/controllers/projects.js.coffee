Project = WikiStacks.Project
Technology = WikiStacks.Technology
ORM = WikiStacks.ORM

class ProjectsFilters extends Spine.Controller

	@include ORM.checkbox
	@include ORM.loaded
	@include ORM.search
	
	el: $ '#projects-filters'
	
	elements:
		'.data-list': 'list'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Technology.bind 'refresh change', @render
	
	render:  =>
		items = Technology.all()
		@list.empty().prepend @view( 'technologies/filters' )( items )
		@loaded()

class ProjectsResults extends Spine.Controller

	@include ORM.loaded
	@include ORM.search
	
	el: $ '#projects-results'
	
	elements:
		'.list-search': 'list'
		
	events:
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Project.bind 'refresh change', @render
		
	render:  =>
		items = Project.all()
		@list.empty().prepend @view( 'projects/results' )( items )
		@loaded()

class ProjectsIndexes extends Spine.Controller
	
	el: $ '#projects-index'

	constructor: ->
		super
		@filters = new ProjectsFilters
		@results = new ProjectsResults

class ProjectsDetails extends Spine.Controller
	
	el: $ '#projects-details'

	constructor: ->
		super
		Project.bind 'refresh change', @render
	
	activate: ( id ) ->
		if Project.exists id 
			@render Project.find id
			
		else 
			Project.fetch id
			
		@el.addClass 'stack-item-active'
			
	render:  ( item ) =>
		#@list.empty().prepend @view( 'projects/results' )( items )
		#@loaded()
		
class WikiStacks.Projects extends Spine.Stack

	controllers:
		index: ProjectsIndexes
		details: ProjectsDetails
	
	default: 'index'

	el: $ '#projects'
	
	classNames: 'stack-manager stack-item'
	
	constructor: ->
		super
		Project.fetch()