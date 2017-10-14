class Dictionary
  def initialize
    @dictionary = File.new('hangman/5desk.txt', 'r')
  end

  def random_word
    select_random_line.times { @dictionary.gets }
    $_.chomp.length.between?(5, 12) ? $_.chomp : random_word.strip
    # $_ is the last read string of 'gets'
  end

  def select_random_line
    random_line = rand(@dictionary.count) - 1
    @dictionary.rewind
    random_line
  end
end
