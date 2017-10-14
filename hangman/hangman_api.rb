require_relative 'hangman_game.rb'

class HangmanApi
  def initialize
    @hangman = Hangman.new
  end

  def make_guess(letters)
    @hangman.guess_handler(letters.split)
  end

  def hanged_status
    @hangman.incorrect_guesses.length
  end

  def word_status
    @hangman.correct_guesses.join
  end

  def win?
    true
  end

  def lose?
    @hangman.lose?
  end

  def show_word
    return @hangman.instance_variable_get(:@secret_word).join if win? || lose?
  end
end
