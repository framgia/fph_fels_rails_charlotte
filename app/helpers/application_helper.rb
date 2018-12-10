module ApplicationHelper
	def get_img(user)
    if user.avatar?
      image_tag user.avatar.url 
    else
      image_tag 'https://i.imgur.com/z51mKaZ.png'
    end
  end
end
