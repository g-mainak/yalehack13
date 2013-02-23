class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :name
			t.string :netid
			t.string :fb_id
			t.text :bio
			t.text :skills

			t.timestamps
		end
	end
end
