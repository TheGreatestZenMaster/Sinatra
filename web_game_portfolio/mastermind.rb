class MasterMind
	attr_accessor :colors, :guess, :secret_code, :black, :white, :victory, :is_valid

	def initialize
		@colors = ["R", "B", "Y", "G", "P", "O"]
		@guess = Array.new
		@secret_code = generate_secret_code
		@black = 0
		@white = 0
		@is_valid = true
		@victory = false
	end
	
	def generate_secret_code
		secretcode = Array.new
		4.times {secretcode << (@colors[rand(0..5)])}
		secretcode
	end
					
	def get_human_guess
		if @guess.join.length != 4
			@guess == 'invalid'	
		else
			@guess.each {|x| x.upcase![0] }
		end
	end
	
	def valid
		@is_valid = true
		if @guess.join.length == 4
			message = "Nice Guess!"
			@guess.each do |x| 
				unless @colors.include?(x)
					message = "That is not a valid color!"
					@is_valid = false
				end
			end
		else
			message = "That is not a valid number of colors!"
			@is_valid = false
		end
		message
	end
	
	def check
		if @secret_code == @guess
			@victory = true
			@black = 4
			@white = 0
		else
			@black = 0
			@white = 0
			pos_temp = @secret_code.dup
			col_temp = @guess.dup
			(0..3).each do |x|
				if guess[x] == @secret_code[x]
					@black += 1
					col_temp.delete_at(col_temp.find_index(@guess[x]).to_i)
					pos_temp.delete_at(pos_temp.find_index(@guess[x]).to_i)
				end
			end
			color = col_temp.dup
			position = pos_temp.dup
			pos_temp.each do |x|
				if col_temp.include?(x)
					@white += 1
					color.delete_at(color.find_index(x).to_i)
					position.delete_at(position.find_index(x).to_i)
				end
			end
		end
	end

	def reset
		@count = 0
		@secret_code = generate_secret_code
		@victory = false
	end
end
