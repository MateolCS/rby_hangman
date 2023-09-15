#Class that represents the game of hangman and is saved and loaded by Game class
# get_word - gets random word from words.txt file
# play_round - takes letter as input and checks if it is in the word and displays game status
# game_over? - checks if game is over
# display_game_status - displays game status


class Hangman
  def initialize
    @word = get_word
    @guessed_letters = Array.new(@word.length, "_")
    @wrong_letters = []
    @guesses_left = @word.length + 4
  end

  def get_word
    file = File.open(Dir.pwd + "/data/words.txt")
    words = file.readlines.map(&:chomp)
    words.select! { |word| word.length.between?(5, 12) }
    words.sample.downcase.chomp
  end

  def play_round(in_letter)

    if @wrong_letters.include?(in_letter) || @guessed_letters.include?(in_letter)
      puts "You already guessed that letter!"
      return
    end

    if @word.include?(in_letter)
      @word.split("").each_with_index do |letter, index|
        @guessed_letters[index] = letter if letter == in_letter
      end
    else
      @wrong_letters << in_letter
      @guesses_left -= 1
    end

    display_game_status
  end

  def game_over?
    if @guesses_left == 0 || @guessed_letters.join == @word
      true
    else
      false
    end
  end

  def display_game_status
    puts "Guesses left: #{@guesses_left}"
    puts "Wrong letters: #{@wrong_letters}"
    puts "Word: #{@guessed_letters}"
  end
end



