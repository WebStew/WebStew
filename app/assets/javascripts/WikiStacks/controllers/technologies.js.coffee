Project = WikiStacks.Project
Technology = WikiStacks.Technology
ORM = WikiStacks.ORM

class TechnologiesFilters extends Spine.Controller

	@include ORM.checkbox
	@include ORM.loaded
	@include ORM.search
	
	el: $ '#technologies-filters'
	
	elements:
		'.data-list': 'list'
	
	events:
		'click label': 'toggleCheckbox'
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'

	constructor: ->
		super
		Project.bind 'refresh change', @render
	
	render:  =>
		items = Project.all()
		@list.empty().prepend @view( 'projects/filters' )( items )
		@loaded()
		
class TechnologiesResults extends Spine.Controller

	@include ORM.loaded
	@include ORM.search

	el: $ '#technologies-results'
	
	elements:
		'.list-search': 'list'
		
	events:
		'keyup .data-search-input': 'filter'
		'submit .data-search': 'filter'
	
	constructor: ->
		super
		Technology.bind 'refresh change', @render
	
	render:  =>
		items = Technology.all()
		@list.empty().prepend @view( 'technologies/results' )( items )
		@loaded()
	
class TechnologiesIndexes extends Spine.Controller

	el: $ '#technologies-index'
	
	constructor: ->
		super
		@sidebar = new TechnologiesFilters
		@results = new TechnologiesResults

class TechnologiesDetails extends Spine.Controller

	el: $ '#technologies-detail'
	
	constructor: ->
		super
	
	activate: ( id ) ->
		if Technology.exists id 
			@render Technology.find id
			
		else 
			Technology.fetch id
			
		@el.addClass 'stack-item-active'
			
	render:  ( item ) =>
		#@list.empty().prepend @view( 'projects/results' )( items )
		#@loaded()
		
class WikiStacks.Technologies extends Spine.Stack

	controllers:
		index: TechnologiesIndexes
		details: TechnologiesDetails
	
	default: 'index'

	el: $ '#technologies'
	
	classNames: 'stack-manager stack-item'
	
	constructor: ->
		super
		Technology.fetch()
