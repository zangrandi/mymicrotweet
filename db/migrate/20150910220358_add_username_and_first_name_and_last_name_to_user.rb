class AddUsernameAndFirstNameAndLastNameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :fullname, :string
  end
end
