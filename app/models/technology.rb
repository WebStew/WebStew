class Technology < ActiveRecord::Base

  attr_accessible :description, :name, :project_ids, :title
  
  has_and_belongs_to_many :projects, :join_table => :projects_technologies, :uniq => true
  
end
