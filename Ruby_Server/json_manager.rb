require_relative 'User'
class Json_Manager
  def initialize(file)
    @file = file
  end

  def writeFile(users)
    open(@file, 'w') { |f|
      f.puts users.to_json
    }
  end

  def userToJson(users)
    list_users = []
    users.each { |i| list_users.push(i.to_Hash)
    }
    self.writeFile(list_users)
  end

  def fromFile()
    users = []
    file = File.read(@file)
    hash = JSON.parse(file)
    hash.each { |i| users.push(User.new(i["@username"],i["@name"],i["@email"],i["@id"],i["@f_nac"],i["@foto"]))}
    return users
  end
end