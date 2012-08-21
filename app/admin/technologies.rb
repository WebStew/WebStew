ActiveAdmin.register Technology do

  # Index action
  index do  
    column :name
    column :title
    column :description    
#     column "Projects" do |technology|
#       (technology.projects.map{ |p| "&bull;	" + p.name }).join('<br> ').html_safe
#     end
    
    default_actions
  end
  
  # Filter controls
  filter :name
  # filter :projects_id, :as => :check_boxes, :collection => proc {Project.all()}
 
  # CRUD ations
  form do |f|
    f.inputs "Edit Technology Details" do
      f.input :name
      f.input :title
      f.input :description
      # f.input :projects, as: :check_boxes
    end
    
    f.buttons
  end
  
end
