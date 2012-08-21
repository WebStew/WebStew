ActiveAdmin.register Project do
  
  # Index action
  index do
  
    # Customise the column names
    column :name do |project|
      link_to project.name, project.url, "target" => "_blank"
    end
    
    column :description
#     column "Technologies" do |project|
#       (project.technologies.map{ |p| "&bull;	" + p.name }).join('<br> ').html_safe
#     end
#     column "Type" do |project|
#       (project.types.map{ |p| "&bull;	" + p.name }).join('<br> ').html_safe
#     end
    
    # Keep the default CRUD control
    default_actions
  end
  
  # Filter controls
  filter :name
  # filter :technologies_id, :as => :check_boxes, :collection => proc {Technology.all()}
  # filter :types_id, :as => :check_boxes, :collection => proc {Type.all()}
  
  # CRUD actions
  form do |f|
  
    f.inputs "Edit Project Details" do
      f.input :name
      f.input :url
      f.input :description
      # f.input :technologies, as: :check_boxes
      # f.input :types, as: :check_boxes
    end
    
    f.buttons
  end
  
end
