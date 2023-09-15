require_relative 'hangman'
require_relative 'data_saver'

# Class that represents the game and is responsible for starting, ending, saving and deleting the game
# start - starts the game
# play - plays the game
# end_game - ends the game and asks if player wants to play again

class Game
  include DataSaver

  def initialize
    @game = nil
    start
  end

  def start
    puts "Welcome to Hangman!"
    puts "You can start a new game by typing 'N'"
    puts "You can load a saved game by typing 'L'"
    puts "You can delete a saved game by typing 'D'"
    puts "You can delete all saved games by typing 'A'"
    answer = gets.chomp.downcase

    case answer
    when "n"
      @game = Hangman.new
      play
    when "l"
      @game = load_save
      play
    when "d"
      delete_save
      return 
    when "a"
      delete_all_saves
      return
    else
      puts "Wrong input!"
      start
    end
    
  end

  def play
    if @game == nil
      return 
    end

    until @game.game_over?
      puts "Enter letter or 'save' to save game"
      input = gets.chomp.downcase
      if input == "save"
        create_save(@game)
        return
      else
        @game.play_round(input)
      end
    end
    end_game
  end

  def end_game
    puts "Game over!"
    puts "Would You like to play again? (y/n)"
    answer = gets.chomp.downcase
    if answer == "y"
      start
    else
      puts "Thank You for playing!"
      return
    end
  end
end