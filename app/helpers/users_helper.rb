module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  # def gravatar_for(user, options = { size: 50 })
  # 	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  # 	size = options[:size]
  # 	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  # 	image_tag(gravatar_url, alt: user.name, class: "gravatar")
  # end

  def showProfImage(user)
  	image_tag(user.image, alt: user.name, class: "prof-image")
  end

  def user_actions(user)
    arr = []
    returnedArr = []
    (0..2).each{|i|
      arr.push(user.microposts.all[i])
      arr.push(user.stars.all[-i-1])
      arr.push(user.interests.all[-i-1])
      arr.push(user.comments.all[-i-1])
    }
    arr.sort_by!{|obj| obj.updated_at}
    arr.reverse!
    (0..7).each{|i| returnedArr.push(arr[i]) }
    return returnedArr
  end

  def user_actions_passive(user)
    arr = []
    returnedArr = []
    (0..2).each{|i|
      # arr.push(user.microposts.all[i])
      (0..2).each{|j|
        returnedArr.push(user.microposts.all[i].stars[j])
      }
    }
    return returnedArr
  end

end