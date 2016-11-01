require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
    if guess > SECRET_NUMBER
        message = "Too high!"
    elsif guess <SECRET_NUMBER
        message = "Too low!"
    else
        message = "That is correct! The Secret Number was #{guess}!"
    end
end

get '/' do
    guess = params['guess'].to_i
    message = check_guess(guess)
    erb :index, :locals => {:number => SECRET_NUMBER, :guess => guess, :message => message}
end