class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :sender_id
    	t.integer :receiver_id
    	t.boolean :read, default: false
      t.timestamps null: false
    end
  end
end
