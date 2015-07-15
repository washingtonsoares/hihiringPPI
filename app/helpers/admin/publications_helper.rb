module Admin::PublicationsHelper
  
  def retornaThumb(id)
    @user = User.find(id)
    if @user
      return @user.uid
    end
    return nil
  end
  
  def retornaNome(id)
    @user = User.find(id)
    if @user
      return @user.name
    end
    return nil
  end
  def retornaNomeFormatado(id)
    @user = User.find(id)
    if @user
      return "#{@user.id} #{@user.name}".parameterize
    end
    return nil
  end
  def video_id(url)
    regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
    return url.match(regex)[1]
  end
  
end
