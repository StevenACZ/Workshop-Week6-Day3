require_relative "notes_controller"

module Notes
  def load_notes
    @notes = NotesController.index(@user[:token])
  rescue Net::HTTPError => e
    puts e.response.parsed_response
    puts
  end

  def create_note
    note_data = note_form

    new_note = NotesController.create(note_data, @user[:token])
    @notes << new_note
  rescue Net::HTTPError => e
    puts e.response.parsed_response
    puts
  end

  def update_note(id)
    index = @notes.find_index { |note| note[:id] == id.to_i }
    note_data = note_form

    updated_note = NotesController.update(id, note_data, @user[:token])
    @notes[index] = updated_note
  rescue Net::HTTPError => e
    puts e.response.parsed_response
    puts
  end

  def delete_note(id)
    index = @notes.find_index { |note| note[:id] == id.to_i }

    delete_note = NotesController.destroy(id, @user[:token])
    if delete_note
      @notes[index] = delete_note
    else 
      @notes.reject! { |note| note[:id] == id.to_i }
    end
  rescue Net::HTTPError => e
    puts e.response.parsed_response
    puts
  end

  def toggle(id)
    current_note = @notes.find { |note| note[:id] == id }
    note_data = { pinned: !current_note[:pinned] } if current_note

    updated_note = NotesController.update(id, note_data, @user[:token])
    current_note.merge!(updated_note)
  rescue Net::HTTPError => e
    puts e.response.body ? e.message : e.response.parsed_response
    puts
  end


end