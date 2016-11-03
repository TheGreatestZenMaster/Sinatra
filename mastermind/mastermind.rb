class Game
	attr_accessor :colors

	def initialize
		@colors = ["R", "B", "Y", "G", "P", "O"]
		@guess = Array.new
		
		@linewidth = 40
		@guess_prompt = 
			"-------------------------------
			| Please guess four colors from |
			-------------------------------
			| #{@colors}|
			-------------------------------".lines.map { |line| line.strip.center(@linewidth) }.join("\n")
	end
	
	def play
		@victory = false
		@continue = true
		@count = 0
		generate_secret_code
		while @continue
			begin
			get_human_guess 
			end until valid
			@count += 1
			if @guess == "exit"
				puts "Exiting"
				@continue = false
			else
				check
				_render
				if @victory
					@continue = false
					puts "You win!"
				elsif @count == 12
					@continue = false
					puts "Sorry that was your last guess! Gameover!"
					puts "The secret code was #{@secretcode.inspect}"
				end
			end
			unless @continue
				puts "Would you like to play again? Y/N"
				_retry = gets.chomp
				_retry.upcase!
				if _retry == "Y" || _retry == "YES"
					@continue = true
					reset
				end
			end
		end	
	end
	
	def generate_secret_code
		@output = "#:-------Guess-------------::Black:--:White::\n".center(@linewidth)
		@secretcode = Array.new
		4.times {@secretcode.push(@colors[rand(0..5)])}
	end
					
	def get_human_guess
		puts @guess_prompt
		human_guess = gets.downcase.chomp
		if human_guess == "exit"
			@guess = "exit"
		else
			@guess = human_guess.split(",")
			@guess.each do |x| 
				x.gsub!(/[^a-z]/,'')
				x.upcase!
			end
		end
	end
	
	def valid
		if @guess == "exit"
			return true
		elsif @guess.length != 4
			puts "That is not a valid number of colors!"
			return false
		end
		@guess.each do |x| 
			unless @colors.include?(x)
				puts "That is not a valid color!"
				return false
			end
		end
	end

	def check
		if @secretcode == @guess
			@victory = true
			@black = 4
			@white = 0
		else
			@black = 0
			@white = 0
			pos_temp = @secretcode.dup
			col_temp = @guess.dup
			(0..3).each do |x|
				if @guess[x] == @secretcode[x]
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
	
	def _render
		@output += "#{@count}: #{@guess}    ::  #{@black}  :  :  #{@white}  ::\n".center(@linewidth-20)
		puts @output 
		puts ""
	end
	
	def reset
		@count = 0
		generate_secret_code
		@victory = false
	end
end