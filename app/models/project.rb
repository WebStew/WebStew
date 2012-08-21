class Project < ActiveRecord::Base

  attr_accessible :description, :name, :technology_ids, :url
  
  has_and_belongs_to_many :technologies, :join_table => :projects_technologies, :uniq => true
  # has_and_belongs_to_many :types, :join_table => :projects_types
  
end
