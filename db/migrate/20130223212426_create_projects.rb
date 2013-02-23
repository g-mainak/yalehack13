class CreateProjects < ActiveRecord::Migration
	def change
		create_table :projects do |t|
			t.integer
			t.string :project_name
			t.string :founder_name
			t.string :looking_for
			t.text	:description
			t.integer :rating
			t.integer :consider
			
			t.timestamps
		end
	end
end
