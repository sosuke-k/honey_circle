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

  def user_notifications(user)
    lasttime = user.last_checked # 最後に見た時間
    arr = []
    if user.last_checked? # 既に1回でも見ていたら
      @comments = Comment.where(Comment.arel_table[:updated_at].gt(lasttime)).to_a
      @stars = Star.where(Star.arel_table[:updated_at].gt(lasttime)).to_a
      @interests = Interest.where(Interest.arel_table[:updated_at].gt(lasttime)).to_a
    else # 一回も確認してない場合
      @comments = Comment.all
      @stars = Star.all
      @interests = Interest.all
    end
    arr.push(@comments).push(@stars).push(@interests) #配列の中に配列をぶっこむ
    arr.flatten! # 多次元配列を1次元化
    arr.each_with_index{|i,j|
      if (i.micropost.user != user) #ログインユーザ以外は消す
        arr[j] = nil
      end
    }
    arr.compact! # nilを消去
    arr.sort_by!{|obj| obj.updated_at} #時間でソート
    returnedArr = []
    arr.each{|i|
      # returnedArr.push(i.micropost.user.nickname)
      returnedArr.push('you got ' + i.class.to_s + ' from ' + i.user.nickname )
    }

    return returnedArr
  end

  def user_actions(user)
    arr = []
    returnedArr = []
    begin
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
    rescue
      return []
    end
  end

  def user_actions_passive(user)
    arr = []
    returnedArr = []
    begin
      (0..2).each{|i|
        # arr.push(user.microposts.all[i])
        (0..2).each{|j|
          returnedArr.push(user.microposts.all[i].stars[j])
        }
      }
      return returnedArr
    rescue
      return []
    end
  end

end