require_relative "notes"
require_relative "presenter"
require_relative "requester"
require_relative "session"
require_relative "user"

class Keepable
  include Presenter
  include Requester
  include Session
  include User
  include Notes

  def initialize
    @user = nil
    @notes = []
    @trash = false
  end

  def start
    until print_welcome
      action, _id = select_main_menu_action
      case action
      when "login" then login
      when "create_user" then creater_user
      when "exit" then break
      end
      notes_page if @user
    end
  end

  def notes_page
    load_notes
    print_notes
    action, id = select_notes_menu_action
    until action == "logout"
      case action # case_notes_action
      when "create" then create_note
      when "update" then update_note(id)
      when "delete" then delete_note(id)
      when "toggle" then toggle(id)
      when "trash" then trash_page
      when "logout"
        logout
        break
      end
      print_notes
      action, _id = select_notes_menu_action
    end
  end

  def trash_page
    @trash = true
    print_notes
    action, id = select_trash_menu_action
    until action == "back"
      begin
        case action
        when "delete" then delete_note(id)
        when "recover" then recover(id)
        end
      rescue Net::HTTPError => e
        puts e.response.parsed_response
        puts
      end
      print_notes
      action, id = select_trash_menu_action
    end
  end
end

app = Keepable.new
app.start