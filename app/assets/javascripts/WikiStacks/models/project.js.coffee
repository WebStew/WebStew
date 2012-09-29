
class WikiStacks.Project extends Spine.Model

	@configure 'Project', 'name', 'description', 'technologies', 'type', 'url'
	
	@extend Spine.Model.Ajax