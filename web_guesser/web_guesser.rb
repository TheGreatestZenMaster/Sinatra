require 'sinatra'
require 'sinatra/reloader'

number = rand(101)

get '/' do
    "The Secret Number is #{number}!"
end