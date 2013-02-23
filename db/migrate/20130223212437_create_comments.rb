class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text	:text
    	t.integer :votes
    	t.integer :project_id

      t.timestamps
    end
  end
end
