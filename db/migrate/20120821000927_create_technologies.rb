class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.text :description
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
