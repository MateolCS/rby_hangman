class Hangman
  def initialize
    @word = get_word
    @guessed_letters = Array.new(@word.length, "_")
    @wrong_letters = []
    @guesses_left = @word.length + 4
  end

  def get_word
    words = File.readlines("./lib/5desk.txt")
    words.select! { |word| word.length.between?(5, 12) }
    words.sample.downcase.chomp
  end 



end