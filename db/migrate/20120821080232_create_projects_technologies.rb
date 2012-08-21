class CreateProjectsTechnologies < ActiveRecord::Migration
  def self.up
  
    create_table :projects_technologies, :id => false do |t|
        t.references :project, :null => false
        t.references :technology, :null => false
    end
    add_index :projects_technologies, [:project_id, :technology_id], :unique => true
    add_index :projects_technologies, [:technology_id, :project_id], :unique => true
  end

  def self.down
    drop_table :projects_technologies
  end
end