class Hangman
  require_relative 'dictionary.rb'
  attr_reader :incorrect_guesses, :correct_guesses
  def initialize
    @secret_word = Dictionary.new.random_word.downcase.split('')
    @correct_guesses = Array.new(@secret_word.length, '_')
    @incorrect_guesses = []
  end

  def guess_handler(guesses)
    guesses.chars do |letter|
      break if win? || lose?
      correct_guess?(letter) ? update_correct_guesses(letter) : update_incorrect_guesses(letter)
    end
  end

  def correct_guess?(letter)
    @secret_word.include?(letter)
  end

  def update_incorrect_guesses(letter)
    @incorrect_guesses << letter
    @incorrect_guesses
  end

  def update_correct_guesses(letter)
    @secret_word.each_with_index do |secret_letter, index|
      @correct_guesses[index] = letter if letter == secret_letter
    end
  end

  def win?
    @correct_guesses == @secret_word
  end

  def lose?
    @incorrect_guesses.length == 6
  end
end
