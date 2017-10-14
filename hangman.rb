require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'hangman/hangman_api.rb'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

get '/' do
  session[:game] ||= HangmanApi.new
  game = session[:game]
  erb :index, locals: {
    word_status: game.word_status,
    hanged_status: game.hanged_status,
    secret_word: game.show_word
  }
end

get '/guess' do
  game = session[:game]
  game.make_guess(params['guess'])
  redirect('/')
end
