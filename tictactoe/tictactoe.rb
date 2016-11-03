
#The Game of Tic Tac Toe
class Game
	#initializes the game and then starts one
	def initialize()
		puts "Greetings Challengers! Time to test yourselves!"
		puts "Player 1: What is your name?"
		@player1 = Player.new(gets.chomp)
		puts "Player 2: What is your name?"
		@player2 = Player.new(gets.chomp)
		@display = Display.new	
		play_game
	end
	
	#the main game loop
	def play_game
		continue = true
		while continue
			count = 0
			while true
				@player1, @player2 = @player2, @player1 if @player2.turn == :first
				@player1.make_move(@display)
				count += 1
				if @player1.check_for_victory(@display.board)
					puts "#{@player1.name} Wins!"
					break
				elsif count == 9
					puts "Game Over! It was a tie!"
					break
				else
					@player2.make_move(@display)
					count += 1
					if @player2.check_for_victory(@display.board)
						puts "#{@player2.name} Wins!"
						break
					elsif count == 9
						puts "Game Over! It was a tie!"
						break
					end
				end
			end
			puts @player1.display_stats
			puts @player2.display_stats
			new_game = new_game?
			if new_game
				reset_game
			end
		end
	end

	#asks the player if they want to continue
	def new_game?
		_response = ""
		until _response == "yes" || _response == "no"
			puts "Would you like to continue? Yes/No"
			_response = gets.chomp.downcase
			_response == "yes"? new_game = true : new_game = false
		end
		new_game
	end
	
	#resets the game
	def reset_game
		puts "The Game has been reset!"
		@display.reset
	end
end
	
class Player
	attr_accessor :symbol, :name, :wins, :loses, :turn
	@@symbols = ["X", "O"].to_a
	@@turns = [:first, :second].to_a
	
	#initalizes the players
	def initialize(name)
		@name = name
		@symbol = ""
		choose_symbol 
		@turn = ""
		choose_turn
		@wins = 0
		@loses = 0
		puts "#{@name} is '#{@symbol}'. #{@name} goes #{@turn}."
	end
	
	#checks for victory condition
	def check_for_victory(display)
		victory = false
		victory_conditions = [[:one, :two, :three], [:four, :five, :six], [:seven, :eight, :nine], [:one, :four, :seven],[:two, :five, :eight],[:three, :six, :nine],[:one, :five, :nine],[:seven, :five, :three]].to_a
		victory_conditions.each do |sub_array|
			if display[sub_array[0]] == @symbol && display[sub_array [1]] == @symbol && display[sub_array[2]] == @symbol
				victory = true
				@wins += 1
				@turn = :second
			end
		end
		return victory
	end
	
	#chooses the players' symbols randomly
	def choose_symbol
		if @@symbols.count == 2
			@symbol = @@symbols[rand(0..1)]
			@@symbols.delete(@symbol)
		else
			@symbol = @@symbols[0]
			@@symbols.delete_at(0)
		end
	end
	
	#chooses who goes first randomly
	def choose_turn
		if @@turns.count == 2
			@turn = @@turns[rand(0..1)]
			@@turns.delete(@turn)
		else
			@turn = @@turns[0]
			@@turns.delete_at(0)
		end
	end

	#shows the stats
	def display_stats
		print "#{@name} has #{@wins} wins!"
	end
	
	#processes the move of the player
	def make_move(display)
		puts "It is your turn #{@name}!"
		display.update(self, display.choose)
	end
end
	
class Display
	attr_accessor :board
	#initializes the game board hash
	def initialize
		@linewidth = 45
		@board = Hash[:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9]
		puts ""
		puts "Let's begin".center(@linewidth)
		puts self.display
	end
	
	#Simple display method that shows the board
	def display
		breakline = "---- --- ----"
		puts breakline.center(@linewidth)
		puts "| #{@board[:one]} | #{@board[:two]} | #{@board[:three]} |".center(@linewidth)
		puts breakline.center(@linewidth)
		puts "| #{@board[:four]} | #{@board[:five]} | #{@board[:six]} |".center(@linewidth)
		puts breakline.center(@linewidth)
		puts "| #{@board[:seven]} | #{@board[:eight]} | #{@board[:nine]} |".center(@linewidth)
		puts breakline.center(@linewidth)
		puts "".center(@linewidth)
	end
	
	#updates the hash that stores the values for the board
	def update(player, location)
		puts "#{player.name} made their move!"
		@board[location.to_sym] = player.symbol
		self.display
	end
	
	#resets the board to its original state after a game
	def reset
		@board = Hash[:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9]
		self.display
	end
	
	#gets input and makes sure it is valid
	def choose
		print "Please choose a number!"
		num = gets.chomp
		valid = false
		until valid
			if num.match(/\d+/)
				num = convert_to_word(num.to_i).to_sym
			else
				num = num.downcase.to_sym
			end
			available = (@board[num] != "X" && @board[num] != "O")
			if (@board.keys.include? num) && available
				valid = true
			else
				puts "Sorry that is an illegal move!"
				print "Please choose a number! "
				num = gets.chomp
			end
		end
		num
	end
	
	def convert_to_num(num)
		num.downcase!
		case num
		when "one" then 1
		when "two" then 2
		when "three" then 3
		when "four" then 4
		when "five" then 5
		when "six" then 6
		when "seven" then 7
		when "eight" then 8
		when "nine" then 9
		end
	end
	
	def convert_to_word(num)
		case num
		when 1 then x = "one"
		when 2 then x = "two"
		when 3 then x ="three"
		when 4 then x ="four"
		when 5 then x ="five"
		when 6 then x ="six"
		when 7 then x = "seven"
		when 8 then x = "eight"
		when 9 then x ="nine"
		else
			x = "zero"
		end
		x
	end
end

