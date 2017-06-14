# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p "- Destroy User"
User.destroy_all

p "- Create Admin for Rekordio"
user = User.where(email: "admin@rekordio.com").first
unless user.present?
  admin = User.create(
  			email: 						"admin@rekordio.com", 
  			password: 					"admin321",
    		password_confirmation: 		"admin321", 
    		member_type: 				User::MEMBER_TYPE[:admin], 
    		first_name: 				"Adrian", 
    		last_name: 					"Martinek", 
    		confirmed_at: 				Time.now, 
    		status: 					1, 
    		registered_at: 				Time.now)
  admin = User.find(admin.id.to_s)
  admin.confirm!
end