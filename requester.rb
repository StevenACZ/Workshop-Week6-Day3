module Requester
  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = ["login", "create_user", "exit"]
    gets_option(prompt, options)
  end

  def select_notes_menu_action
    prompt = "create | update ID | delete ID | toggle | trash | logout"
    options = ["create", "update", "delete", "toggle", "trash", "logout"]
    gets_option(prompt, options)
  end

  def login_form
    username = gets_string("username: ", required: true)
    password = gets_string("password: ", required: true)
    { username: username, password: password }
  end

  def user_form
    username = gets_string("username: ")
    password = gets_string("password: ", length: 6)
    { username: username, password: password }
  end

  def note_form
    title = gets_string("title: ")
    body = gets_string("body: ", required: false)
    puts "Select a color (default: white)"
    options = %w[white red green yellow blue magenta cyan]
    color, _rest = gets_option(options.join(" | "), options, required: false)

    data = { title: title, body: body, color: color }
    data.reject! { |_key, value| value.nil? || value.empty? }
  end
  
  private

  def gets_string(prompt, required: true, length: 0)
    print prompt
    input = gets.chomp.strip
    
    if required
      while input.empty? || input.size < length
        puts "Can't be blank" if input.empty?
        puts "Minimun lenght of #{length}" if input.size < length
        print prompt
        input = gets.chomp.strip
      end
    end

    input
  end

  def gets_option(prompt, options, required: true)
    puts prompt
    print "> "
    input = gets.chomp.split.map(&:strip)
    
    unless !required && input.empty?
      until options.include?(input[0])
        puts "Invalid option"
        print "> "
        input = gets.chomp.split.map(&:strip)
      end
    end
    input
  end
end