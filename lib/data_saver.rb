require 'yaml'
# Module for saving and loading game
# get_saves - returns array of saves
# print_saves - prints saves
# saves_exist? - checks if there are any saves
# create_save - saves game to file
# load_save - loads game from file
# delete_save - deletes file that represents saved game
# delete_all_saves - deletes all saves from saves directory

module DataSaver
  def get_saves
    aviable_saves = Dir.glob("./saves/*.yaml").map { |file| File.basename(file, ".yaml") }
  end

  def print_saves
    get_saves.each { |save| puts save }
  end

  def saves_exist?
    get_saves.empty?
  end

  def create_save(game)
    puts "How would You like to name Your save?"
    save_name = gets.chomp
    File.open("./saves/#{save_name}.yaml", "w") { |file| file.write(YAML::dump(game)) }
    puts "Game saved!"
  end

  def load_save
    unless saves_exist?
      puts "Which save would You like to load?"
      print_saves
      game_name = gets.chomp
      until File.exist?("./saves/#{game_name}.yaml")
        puts "There is no save named #{game_name}!"
        puts "Which save would You like to load?"
        game_name = gets.chomp
      end
        game = YAML::load(File.read("./saves/#{game_name}.yaml"), permitted_classes: [Hangman])
        puts "Game loaded!"
        game
    else
      puts "There are no saves!"
      return 
    end
  end

  def delete_save
    unless saves_exist?
      print_saves
      puts "Which save would You like to delete?"
      game_name = gets.chomp
      until File.exist?("./saves/#{game_name}.yaml")
        puts "There is no save named #{game_name}!"
      end
        File.delete("./saves/#{game_name}.yaml")
        puts "Save #{game_name} deleted!"
    else
      puts "There are no saves!"
      return 
    end

  end

  def delete_all_saves
    unless saves_exist?
      print_saves
      puts "Are You sure You want to delete all saves? (y/n)"
      answer = gets.chomp
      if answer == "y"
        Dir.glob("./saves/*.yaml").each { |file| File.delete(file) }
        puts "All saves deleted!"
      else
        puts "No saves deleted!"
      end
    else
      puts "There are no saves!"
      return 
    end
  end
end