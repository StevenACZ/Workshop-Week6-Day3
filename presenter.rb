require "terminal-table"

module Presenter
  def print_welcome
    puts "#########################"
    puts "#  Welcome to Keepable  #"
    puts "#########################"
  end

  def print_notes
    table = Terminal::Table.new
    table.title = "#{@user[:username]}'s Notes'"
    table.headings = %w[ID Title Body Color Pinned Deleted\ At]
    table.rows = @notes.map do |note|
      [
        note[:id],
        note[:title],
        note[:body],
        note[:color],
        note[:pinned] || nil,
        note[:deleted_at]
      ]
    end
    puts table
  end

  def notes
    if @trash
      @notes.select { |note| note[:delete_at] }.sort_by { |note| note[:pinned] ? 0 : 1 }
    else
      @notes.select { |note| note[:delete_at].nil? }.sort_by { |note| note[:pinned] ? 0 : 1 }
    end
  end

  def sorte_notes
    notes.sort_by { |note|  }
  end
end