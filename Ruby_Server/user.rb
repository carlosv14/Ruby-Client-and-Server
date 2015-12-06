require 'json'
class User

  def initialize(username, name, email, id,f_nac , foto)
      @username = username
      @name = name
      @email = email
      @id = id
      @f_nac = f_nac
      @foto = foto
  end

  def to_Hash
    hash= {}
   self.instance_variables.each do |var|
     hash[var] = self.instance_variable_get(var)
   end
   return hash
  end

  def self.show(u)
    return "User name: " + u.instance_variable_get("@username").to_s + "\nName: " + u.instance_variable_get("@name").to_s + "\nEmail: " + u.instance_variable_get("@email").to_s + "\nID: " + u.instance_variable_get("@id").to_s + "\nFecha Nacimiento: " + u.instance_variable_get("@f_nac").to_s + "\nFoto: " + u.instance_variable_get("@foto").to_s
  end

  def self.emailParse(u)
    return "<p>User name: " + u.instance_variable_get("@username").to_s + "</p>" + "<p> Name: " + u.instance_variable_get("@name").to_s + "</p>" +"<p>Email: " + u.instance_variable_get("@email").to_s + "</p>" +"<p>ID: " + u.instance_variable_get("@id").to_s + "</p>" +"<p>Fecha Nacimiento: " + u.instance_variable_get("@f_nac").to_s + "</p>" + "<p>Foto: " + u.instance_variable_get("@foto").to_s+"</p>"
  end

  def self.imgSource(u)
    return u.instance_variable_get("@foto").to_s
  end
end