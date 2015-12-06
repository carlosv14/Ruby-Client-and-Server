require 'socket'

hostname = 'localhost'
port = 399


while true
  puts '1.Add User'
  puts '2.Seach User'
  puts '3.Delete User'
  puts '4.Send Email'
  puts 'Option: '
  op = gets.to_i
  begin
    case op
      when 1
        s = TCPSocket.open(hostname, port)
        s.send(op.to_s,0)
        data =''
        while data!="Success"
          data = s.recv(1024).to_s.chomp
          if data!="Success"
          puts data
          info  = gets.chomp
          s.send(info,0)
          elsif data == "Success"
            op = - 1
          end
        end
      when 2
        s = TCPSocket.open(hostname, port)
        s.send(op.to_s,0)
        data =''
        while true
          data = s.recv(1024).to_s.chomp
          puts data
          if data=="Enter User Name: "
            info  = gets.chomp
            s.send(info,0)
          elsif
          op = - 1
            break
          end
        end
      when 3
        s = TCPSocket.open(hostname, port)
        s.send(op.to_s,0)
        data =''
        while true
          data = s.recv(1024).to_s.chomp
          puts data
          if data=="Enter User Name: "
            info  = gets.chomp
            s.send(info,0)
          elsif
          op = - 1
            break
          end
        end
      when 4
        s = TCPSocket.open(hostname, port)
        s.send(op.to_s,0)
        data =''
        while true
          data = s.recv(1024).to_s.chomp
          puts data
          if data=="Enter User Name: "
            info  = gets.chomp
            s.send(info,0)
          elsif data == "Enter Email Recipient: "
            info  = gets.chomp
            s.send(info,0)
           else
          op = - 1
            break
          end
        end
    end
  rescue
    puts @error_message="#{$!}"
  ensure
    s.close
  end

end