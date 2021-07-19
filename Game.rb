require "./Player"

class Game
  attr_accessor :num_1, :num_2, :current_player, :player_1, :player_2

  Wrong = "Seriously? No!"
  Correct = "YES! You are correct."

  # Initialize all variables for the start of the game
  def initialize
    @current_player = 1
    @player_1 = Player.new
    @player_2 = Player.new
    @num_1 = rand(1..20)
    @num_2 = rand(1..20)
  end

  # Dictates if the main game loop should end
  def end_game (player)
    if (player.life == 0)
      return false
    end
    return true
  end

  # Checks if user inputs the correct answer
  def check_answer(answer)
    result = @num_1 + @num_2
    if answer == result
      return true
    end
    return false
  end

  # Resets the numbers and current player for the next round
  def reset
    @num_1 = rand(1..20)
    @num_2 = rand(1..20)
    if @current_player == 1
      @current_player = 2
    else
      @current_player = 1
    end
  end

  # Finds the winner of the game
  def find_winner
    if @player_1.life == 0
      return 2
    end
    return 1
  end

  # Finds the score of the winner
  def find_score 
    player = self.find_winner
    if player == 1
      return @player_1.life
    end
    return @player_2.life
  end

  # Main game loop
  def start

    while (self.end_game(@player_1) && self.end_game(@player_2))

      puts "Player #{@current_player}: What does #{@num_1} plus #{num_2} equal?"

      # Get player's answer
      answer = gets.chomp.to_i
      
      # Prints correct output based on answer
      if (self.check_answer(answer))
        puts "Player #{@current_player}: #{Correct}"
      elsif !check_answer(answer)
        puts "Player #{@current_player}: #{Wrong}"

        # Player loses life when inputs wrong answer
        if @current_player == 1
          @player_1.lose_life
        elsif @current_player == 2
          @player_2.lose_life
        end
      end
      
      # Output current score/lives of each player
      puts "P1: #{@player_1.life}/3 vs P2: #{@player_2.life}/3"

      # Outputs new turn if game has not ended
      if (@player_1.life > 0 && @player_2.life > 0)
        puts "----- NEW TURN -----"
      end

      # Resets current player and numbers for the next game
      self.reset
    end

    winner = self.find_winner
    winner_score = self.find_score
    puts "Player #{winner} wins with a score of #{winner_score}/3"
    puts "----- GAME OVER -----"
    puts "Good bye!"
  end

end
