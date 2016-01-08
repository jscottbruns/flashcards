class MathExercise

  def initialize
    setup
  end

  def play
    @right_count = @wrong_count = 0
    play_count = 1

    print "#{red}READY... "
    sleep(1.5)
    print "#{yellow}SET... "
    sleep(1.5)
    puts "#{green}GO!!"
    puts reset

    start_time

    while true
      if ask(prompt)
        @right_count += 1
      else
        @wrong_count += 1
      end

      again? if play_count % game_size == 0
      play_count += 1
    end
  end

  private

  def start_time
    @start_time ||= Time.now.to_i
  end

  def end_time
    @end_time ||= Time.now.to_i
  end

  def total_time
    end_time - start_time
  end

  def game_size
    @game_size ||= gets.chomp.to_i
  end

  def again?
    print "You got #{@right_count} out of #{game_size} correct in #{total_time} seconds... "
    if (@right_count.to_f / game_size.to_f).round(1) >= 0.8
      puts "Super job!! You got an A"
    elsif (@right_count.to_f / game_size.to_f).round(1) >= 0.6
      puts "Good job but keep practicing! Looks like you got a C"
    else
      puts "Looks like you might need to keep practicing."
    end

    @right_count = @wrong_count = 0

    print "Want to play again? [Y/n] "
    if gets.chomp.eql? "n"
      puts "Thanks for playing Ava!! Bye :)"
      exit
    end
  end

  def shuffle
    (@a, @b) = [rand(@level), rand(@level)]
  end

  def prompt
    shuffle
    print "#{@a} #{operation} #{@b} = "
    gets.chomp.to_i
  end

  def right?(answer)
    answer == @a.public_send(operation, @b)
  end

  def ask(answer)
    if right?(answer)
      puts "#{green}#{right[rand(right.length-1)]}"
      puts reset
    else
      puts "#{red}#{wrong[rand(wrong.length-1)]} #{@a} #{operation} #{@b} equals #{@a.public_send(operation, @b)}"
      puts reset
    end

    right?(answer)
  end

  def operation
    @operation
  end

  def setup
    @operation = set_operation
    while @operation.nil?
      puts "#{red}Oops, try again#{reset}"
      @operation = set_operation
    end

    @game_size = set_game_size
    while !@game_size.is_a?(Integer) || @game_size <= 0
      puts "#{red}Oops, try again#{reset}"
      @game_size = set_game_size
    end

    @level = set_level
    while ![10, 40, 90].include?(@level)
      puts "#{red}Oops, try again#{reset}"
      @level = set_level
    end
  end

  def set_operation
    puts "What math operation do you want to play?"
    puts "1)\tAddition"
    puts "2)\tSubtraction"
    puts "3)\tMultiplication"
    puts "4)\tDivision"
    #puts "5)\tMix it up!"
    print "> "

    case gets.chomp.to_i
    when 1
      op = "+"
    when 2
      op = "-"
    when 3
      op = "x"
    when 4
      op = "/"
    end

    op
  end

  def set_game_size
    print "How many questions should I give you? "
    gets.chomp.to_i
  end

  def set_level
    puts "How difficult should I make it?"
    puts "1)\tEasy"
    puts "2)\tMedium"
    puts "3)\tHard"
    print "> "

    gets.chomp.to_i ** 2 * 10
  end

  def green
    "\033[0;32m"
  end

  def red
    "\033[0;31m"
  end

  def yellow
    "\033[1;33m"
  end

  def reset
    "\033[0m"
  end

  def right
    [
      "Good job!",
      "Way to go!",
      "You're awesome!!",
      "You're getting pretty good!",
      "You're a regular genius!",
      "Way to go smart girl!",
      "Ding ding ding!!",
      "Kick butt!",
      "Rock on!",
      "Go Ava!!"
    ]
  end

  def wrong
    [
      "Sorry!",
      "Nope, try again!",
      "Wrong!",
      "Errrrrrrr -",
      "Hmmm, doesn't look right -",
      "Keep thinking -",
      "Getting closer...",
      "Keep trying, you'll get it!",
      "Almost, but not quite right -"
    ]
  end
end

MathExercise.new.play