require_relative 'hangman_game.rb'

class HangmanApi
  def initialize
    @hangman = Hangman.new
  end

  def make_guess(letters)
    @hangman.guess_handler(letters)
  end

  def hanged_level
    @hangman.incorrect_guesses.length
  end

  def word_status
    @hangman.correct_guesses.join(' ')
  end

  def incorrect_guesses
    @hangman.incorrect_guesses
  end

  def win?
    @hangman.win?
  end

  def lose?
    @hangman.lose?
  end

  def show_word
    return @hangman.instance_variable_get(:@secret_word).join if win? || lose?
  end
end
