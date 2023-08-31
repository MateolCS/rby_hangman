include 'yaml'
# Module for saving and loading game
# get_saves - prints all aviable saves
# create_save - saves game to file
# load_save - loads game from file
# delete_save - deletes file that represents saved game
# delete_all_saves - deletes all saves from saves directory

module DataSaver
  def get_saves
    aviable_saves = Dir.glob("./saves/*.yaml").map { |file| File.basename(file, ".yaml") }
    puts "Aviable saves:"
    aviable_saves.each { |save| puts save }
  end

  def create_save(game)
    puts "How would You like to name Your save?"
    save_name = gets.chomp
    File.open("./saves/#{save_name}.yaml", "w") { |file| file.write(YAML::dump(game)) }
    puts "Game saved!"
  end

  def load_save
    puts "Which save would You like to load?"
    game_name = gets.chomp
    until File.exist?("./saves/#{game_name}.yaml")
      puts "There is no save named #{game_name}!"
      puts "Which save would You like to load?"
      game_name = gets.chomp
    end
      game = YAML::load(File.read("./saves/#{game_name}.yaml"))
      puts "Game loaded!"
      game
  end

  def delete_save
    puts "Which save would You like to delete?"
    game_name = gets.chomp
    until File.exist?("./saves/#{game_name}.yaml")
      puts "There is no save named #{game_name}!"
    end
      File.delete("./saves/#{game_name}.yaml")
      puts "Save #{game_name} deleted!"
  end

  def delete_all_saves
    puts "Are You sure You want to delete all saves? (y/n)"
    answer = gets.chomp
    if answer == "y"
      Dir.glob("./saves/*.yaml").each { |file| File.delete(file) }
      puts "All saves deleted!"
    else
      puts "No saves deleted!"
    end
  end
end