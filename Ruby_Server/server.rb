require 'socket'
require_relative 'User'
require_relative 'Validations'
require_relative 'Json_Manager'
require 'rest-client'
require 'mailgun'

def send_complex_message(text,url,email)
  filename = url.split("\\")
  mg_client = Mailgun::Client.new "key-9b2be08330ce6fe41a9a15a950f624c0"
  mb_obj = Mailgun::MessageBuilder.new()
  mb_obj.set_from_address("mailgun@sandboxc53a54ee60d74130ad038e8fb6c64c34.mailgun.org", {"first"=>"User", "last" => "Manager"});
  mb_obj.add_recipient(:to, email);
  mb_obj.set_subject("User Information");
  mb_obj.add_inline_image(url, filename.last);
  mb_obj.set_html_body('<html>  <body>' + text + '<img src='"cid:" +filename.last+' style=width:128px;height:128px;>  </body></html>')
  result = mg_client.send_message( "sandboxc53a54ee60d74130ad038e8fb6c64c34.mailgun.org", mb_obj)
  puts result
end

server = TCPServer.open(399)
op = 0;
users = []

json_m = Json_Manager.new("users.txt")
if(File.exist?('users.txt'))
users = json_m.fromFile()
end
def searchUser(users,searchuser)
  users.each { |i| if i.instance_variable_get("@username") == searchuser
                     return i
                   end
  }
  return nil
end
loop {
  puts "running on " + Socket.gethostname.to_s
  Thread.start(server.accept) do |client|
  begin
   op = client.recv(1024).to_i
   puts op
  case op
    when 1
    user = User.new("","","","","","")
      while true
        client.puts "Enter Username:"
        username = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@username,username)
        if username!="" and Validations.Unique(users,username,0)
          break
        end
      end
      while true
        client.puts "Enter Name: "
        name = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@name,name)
        if name!=""
         break
        end
      end
      while true
        client.puts "Enter E-mail: "
        email = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@email,email)
        if email!="" and Validations.Unique(users,email,1) and Validations.validEmail(email)
         break
        end
      end
      while true
        client.puts "Enter ID: "
        id = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@id,id)
        if id!="" and Validations.validID(id) and Validations.Unique(users,id,2)
          break
        end
      end
      while true
        client.puts "Enter Birth Date: "
        f_nac = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@f_nac,f_nac)
        if f_nac!="" and Validations.validDate(f_nac)
          break
        end
      end
      while true
        client.puts "Enter Profile Image: "
        foto = client.recv(1024).to_s.chomp
        user.instance_variable_set(:@foto,foto)
        if foto!=""
          break
        end
      end


      users.push(user)
      puts "no more info"
      client.puts "Success"
      json_m.userToJson(users)
    when 2
      client.puts "Enter User Name: "
      searchuser = client.recv(1024).to_s.chomp
      u = searchUser(users,searchuser)
      if !u.nil?
        client.puts User.show(u)
      else
        client.puts "Not Found!"
      end
    when 3
      client.puts "Enter User Name: "
      searchuser = client.recv(1024).to_s.chomp
      u = searchUser(users,searchuser)
      if !u.nil?
        users.delete(u)
        client.puts "Success"
        json_m.userToJson(users)
      else
        client.puts "Not Found!"
      end
    when 4
      client.puts "Enter User Name: "
      searchuser = client.recv(1024).to_s.chomp
      u = searchUser(users,searchuser)
      if !u.nil?
        send_complex_message(User.emailParse(u),"C:\\Users\\Carlos Varela\\Pictures\\file.jpg","cvarela1496@gmail.com")
        client.puts "Success"
        json_m.userToJson(users)
      else
        client.puts "Not Found!"
      end
  end
   rescue
   puts @error_message="#{$!}"
   ensure

   client.close
  end
end


}