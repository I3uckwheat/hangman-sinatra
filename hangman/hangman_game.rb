class Hangman
  require_relative 'dictionary.rb'
  attr_reader :incorrect_guesses, :correct_guesses
  def initialize
    @secret_word = Dictionary.new.random_word.downcase.split('')
    @correct_guesses = Array.new(@secret_word.length, '_')
    @incorrect_guesses = []
  end

  def display_playfield
    puts hanged_status
    puts ''
    puts @correct_guesses.to_s
    puts '----------------------------'
    puts 'Incorrect Guesses'
    puts @incorrect_guesses.to_s
    puts ''
  end

  def guess_handler(guesses)
    guesses.each do |letter|
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

  def hanged_status
    case @incorrect_guesses.length
    when 1
      [['O'], [' '], [''], ['']]
    when 2
      [[' O'], [' |'], [' |'], ['']]
    when 3
      [[' O'], ['\\|'], [' |'], ['']]
    when 4
      [[' O'], ['\\|/'], [' |'], ['']]
    when 5
      [[' O'], ['\\|/'], [' |'], ["\/"], ['']]
    when 6
      [[' O'], ['\\|/'], [' |'], ["\/ \\"], ['']]
    end
  end

  def win?
    @correct_guesses == @secret_word
  end

  def lose?
    @incorrect_guesses.length == 6
  end

  def save_the_game
    save_game(to_json)
  end

  def to_json
    JSON.generate(secret_word: @secret_word,
                  correct_guesses: @correct_guesses,
                  incorrect_guesses: @incorrect_guesses)
  end

  def save_game(string)
    File.open('saved.json', 'w') do |game_file|
      game_file.write(string)
    end
  end

  def load_game
    File.open('saved.json', 'r') do |game_file|
      game_state = JSON.parse(game_file.read)
      @secret_word = game_state['secret_word']
      @correct_guesses = game_state['correct_guesses']
      @incorrect_guesses = game_state['incorrect_guesses']
    end
  end
end
