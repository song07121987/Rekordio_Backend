class AddUserIdToMedia < ActiveRecord::Migration
  def change
  	add_column :media, :user_id, 	:integer
  	add_column :media, :type, 		:integer
  end
end
