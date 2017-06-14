class Endpoints::RekMedia < Grape::API

	resources :media do

    desc "Test media endpoints"
    post :test  do
      data = {data: params}
      data
    end

    desc "Get voice files"
    get do
      user_id = params[:user_id]
      media_id = params[:media_id]

      if user_id.present?
        user = User.where(id: user_id).first
        if user.present?
          # media = user.media.all
          if media_id.present?
            media = media.where(id: media_id).first
            if media.present?
              media = media.api_detail
              data = {response: "success", status: "get_media", message: "Got media successfully", data: media, count: 1}
            else
              data = {response: "fail", status: "fail_media", message: "There are no such media", data: [], count: 0}
            end
          else
            media = user.media.all.order("created_at DESC")
            media = media.map{|media_item| media_item.api_detail}
            data = {response: "success", status: "get_media", message: "Got media successfully", data: media, count: media.count}
          end
        else
          data = {response: "fail", status: "fail_media", message: "There are no such user", data: [], count: 0}
        end
      else
        # media = Medium.all
        if media_id.present?
          media = media.where(id: media_id).first
          if media.present?
            media = media.api_detail
            data = {response: "success", status: "get_media", message: "Got media successfully", data: media, count: 1}
          else
            data = {response: "fail", status: "fail_media", message: "There are no such media", data: [], count: 0}
          end
        else
          media = Medium.all.order("created_at DESC")
          media = media.map{|media_item| media_item.api_detail}
          data = {response: "success", status: "get_media", message: "Got media successfully", data: media, count: media.count}
        end
      end
      data
    end


  	desc "Upload a voice file"
    params do
      requires :user_id,                type: String,   desc: "User ID posted voice file"
      # requires :file, 		          		type: String,   desc: "zhon@admin.com"
      requires :title,                  type: String,   desc: "Voice title"
    end
    post :upload_audio do
    	user = User.find(params[:user_id])

      if user.present?
        media = user.media.new(
              title:          params[:title],
              file:           params[:file],
              type:           1
        )
        if media.save
          data = {response: "success", status: "uploaded", message: "Uploaded successfully."}
        else
          key, val = media.errors.messages.first
          data = {response: "fail", status: key, message: media.errors.full_messages.first}
        end
      else
        data = {response: "fail", status: "user_not_existed", message: "There are no this user."}
      end

      data

    end

    desc "Post a audio file"
    params do
      requires :user_id,                type: String,   desc: "User ID posted voice file"
      # requires :file,                   type: String,   desc: "zhon@admin.com"
      requires :title,                  type: String,   desc: "Voice title"
      requires :duration,               type: Integer,   desc: "Voice title"
    end
    post :post_audio do
      user = User.find(params[:user_id])

      if user.present?
        media = user.media.new(
              title:          params[:title],
              file:           params[:file],
              duration:       params[:duration],
              type:           1
        )
        if media.save
          data = {response: "success", status: "uploaded", message: "Uploaded successfully."}
        else
          key, val = media.errors.messages.first
          data = {response: "fail", status: key, message: media.errors.full_messages.first}
        end
      else
        data = {response: "fail", status: "user_not_existed", message: "There are no this user."}
      end

      data

    end

	end	
end