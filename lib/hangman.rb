class Hangman
  def initialize
    @word = get_word
    # @guessed_letters = Array.new(@word.length, "_")
    @wrong_letters = []
    # @guesses_left = @word.length + 4
    puts @word
  end

  def get_word
    words = File.readlines("words.txt", 'r')
    puts words
    words.select! { |word| word.length.between?(5, 12) }
    words.sample.downcase.chomp
  end 

  def play_round(in_letter)
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