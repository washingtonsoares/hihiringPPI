module Admin::UsersHelper
  def eh_amigo(user_current_id,user_url_id)
    @teste1 = Admin::Friend.find_by(user1: user_current_id,user2: user_url_id)
    @teste2 = Admin::Friend.find_by(user2: user_current_id,user1: user_url_id)

    if (@teste1!=nil)
      if (@teste1.accept == true)
        return 3
      end
      return true
    end

    if (@teste2!=nil)
      if (@teste2.accept == true)
        return 3
      end
      return true
    end

      return false
  end

  def new_otifications
    return  Admin::Friend.where(new: 0,user2: current_user,accept: 1,rejected: 0).order("id DESC")
  end

  def eh_colega(user1,user2)
    if (user1.ocupation == "Professor" && user2.ocupation == "Professor") || (user1.ocupation == "Aluno" && user2.ocupation == "Aluno")
        return "colega"
    elsif (user1.ocupation == "Aluno" && user2.ocupation == "Professor")
        return "Professor"
    else
        return "Aluno"
    end
  end

end
