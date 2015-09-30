# Player selects an item, computer selects an item, items are compared and outcome occurs.
require 'pry'

class Hand
  include Comparable

  attr_reader :choice

  def initialize(choice)
    @choice = choice
  end

  def <=>(other_hand)
    if choice == other_hand.choice
      0
    elsif choice == "p" && other_hand.choice == "r" ||
          choice == "r" && other_hand.choice == "s" ||
          choice == "s" && other_hand.choice == "p"
      +1
    else
      -1
    end
  end

  def display_winning_message
    case choice
    when "p"
      puts "Paper wraps rock!"
    when "r"
      puts "Rock breaks scissors!"
    when "s"
      puts "Scissors cuts paper!"
    end
  end
end

class Player
  attr_accessor :hand
  attr_reader   :name

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Please choose an item [P/R/S]:"
      choice = gets.chomp.downcase
    end until Game::CHOICES.include?(choice)
    self.hand = Hand.new(choice)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.each_key.to_a.sample)
  end
end

class Game
  CHOICES = { "p" => "Paper", "r" => "Rock", "s" => "Scissors" }

  attr_reader :human, :computer

  def initialize
    @human    = Human.new("Joe")
    @computer = Computer.new("iMac")
  end

  def compare_hands
    if human.hand == computer.hand
      puts "It's a tie!"
      puts "#{human.name} choose #{CHOICES[human.hand.choice].downcase} " +
           "and #{computer.name} choose #{CHOICES[human.hand.choice].downcase}"
    elsif human.hand > computer.hand
      puts "#{human.name} won!"
      human.hand.display_winning_message
    elsif human.hand < computer.hand
      puts "#{computer.name} won!"
      computer.hand.display_winning_message
    end
  end

  def play
    human.pick_hand
    computer.pick_hand
    binding.pry
    compare_hands
  end
end

Game.new.play
