class Medium < ActiveRecord::Base
	self.inheritance_column = :_type_disabled

	# mount_uploader :file, MediaUploader

	validates :title,  			presence: true
	validates :file,  			presence: true

	belongs_to :user,			class_name: "User"

	def get_duration_string
		hours 	= 	duration / 3600
		mins 	= 	((duration % 3600) / 60)
		secs 	= 	((duration % 3600) % 60)
		"%02d : " % [hours] + "%02d : " % [mins] + "%02d" % [secs]
	end

	def api_detail
	{
		id: id.to_s,
		title: title,
		# file: file.url,
		file: file,
		created_time:created_at.strftime("%Y-%m-%d %H:%M:%S"),
		user_id: user.id.to_s,
		user_name: user.first_name + " " + user.last_name,
		type: type.to_s,
		duration: duration
	}
	end

	def media_info_detail
	{
		id: 				id.to_s,
		title: 				title,
		created_time: 		created_at.strftime("%Y-%m-%d %H:%M:%S"),
		user_id: 			user.id.to_s,
		user_name: 			user.full_name,
		type: 				type.to_s,
		duration: 			get_duration_string
	}
	end
end
