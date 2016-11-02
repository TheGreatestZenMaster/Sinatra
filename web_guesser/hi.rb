require 'sinatra'

class Hi < Sinatra::Base
    get '/' do
    'Hello, World!'
    end
end

#https://rubyonrails-thezenmaster.c9users.io/

#ruby hi.rb -p $PORT -o $IP