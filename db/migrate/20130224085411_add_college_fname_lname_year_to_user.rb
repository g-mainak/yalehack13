class AddCollegeFnameLnameYearToUser < ActiveRecord::Migration
  def change
  	add_column :users, :year, :integer
  	add_column :users, :fname, :string
  	add_column :users, :lname, :string
  	add_column :users, :college, :string
  end
end
