
#The Game of Tic Tac Toe
class Game
	attr_accessor :display
	#initializes the game and then starts one
	def initialize()
		@display = Display.new	
	end

	def valid(num)
		valid = false
		if num == 'X' || num == 'O'
			valid = true
		end
		valid
	end
	
	def check_for_tie
		tie = false
		tie = true if @display.board.all?{|x,y| y.is_a?(String)}
		tie
	end
	
	def check_for_victory(symbol)
		victory = false
		victory_conditions = [[:one, :two, :three], [:four, :five, :six], [:seven, :eight, :nine], [:one, :four, :seven],[:two, :five, :eight],[:three, :six, :nine],[:one, :five, :nine],[:seven, :five, :three]].to_a
		victory_conditions.each do |sub_array|
			if @display.board[sub_array[0]] == symbol && @display.board[sub_array [1]] == symbol && @display.board[sub_array[2]] == symbol
				victory = true
			end
		end
		return victory
	end
	
	#resets the game
	def reset_game
		@display.reset
		return "The Game has been reset!"
	end
end

class Display
	attr_accessor :board

	def initialize
		@board = Hash[:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9]
	end
	
	#updates the hash that stores the values for the board
	def update(player, location)
		@board[location] = player
	end
	
	#resets the board to its original state after a game
	def reset
		@board = Hash[:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9]
	end
end

