
class WikiStacks.Technology extends Spine.Model

	@configure 'Technology', 'name', 'title', 'description', 'projects'	
	
	@extend Spine.Model.Ajax
	
	@url: '/technologies'