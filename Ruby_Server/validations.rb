require_relative 'User'
class Validations
  VALID_EMAIL_REGEX = /(\w+(.)+@\w+(?:\.\w+)+)/i
  VALID_DATE_REGEX = /\A(?:0?[1-9]|[1-2]\d|3[01])\/(?:0?[1-9]|1[0-2])\/\d{4}\Z/
  VALID_ID_REGEX = /(\d{4}\-\d{4}\-\d{5})/

  def self.validEmail(email)
    if email =~ VALID_EMAIL_REGEX
      return true
    else
      return false
    end
  end

  def self.validDate(date)
    if date =~ VALID_DATE_REGEX
      return true
    else
      return false
    end
  end

  def self.validID(id)
    if id=~VALID_ID_REGEX
      return true
    else
      return false
    end
  end

  def self.Unique(users,param,paramtype)
    users.each { |i|
      if paramtype == 0
        if i.instance_variable_get("@username") == param
          return false
        end
      elsif paramtype ==1
        if i.instance_variable_get("@email") == param
          return false
        end
      else
        if i.instance_variable_get("@id") == param
          return false
        end
      end
      }
    return true
  end
end