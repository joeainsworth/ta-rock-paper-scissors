# 1. get input from player
# 2. get input for computer
# 3. compare outcomes paper > rock, rock > scissors, scissors > paper or tie
require 'pry'

CHOICES = { "p" => "Paper", "r" => "Rock", "s" => "Scissors" }

def say(msg)
  puts "\n=> #{msg}"
end

def play_turn(player_choice, computer_choice)
 if player_choice == computer_choice
   "It's a tie!"
 elsif player_choice == "p" && computer_choice == "r" ||
       player_choice == "r" && computer_choice == "s" ||
       player_choice == "s" && computer_choice == "p"
   puts display_winning_turn(player_choice)
   "Player wins!"
 else
  puts display_winning_turn(computer_choice)
   "Computer wins!"
 end
end

def display_winning_turn(player_choice)
  case player_choice
  when "p"
    "Paper wraps rock!"
  when "r"
    "Rock breaks scissors!"
  when "s"
    "Scissors cuts paper!"
  end
end

loop do
  begin
    say "Please chooose an item: (P/R/S)"
    player_choice = gets.chomp.downcase
  end until CHOICES.has_key?(player_choice)

  computer_choice = %w[p r s].sample

  puts "\n#{CHOICES[player_choice]} vs #{CHOICES[computer_choice]}\n"

  puts play_turn(player_choice, computer_choice)

  say "Would you like to play again? (y/n)"
  break if gets.chomp.downcase != "y"
end
