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
  hidden ||= {}

  erb :index, locals: {
    word_status: game.word_status,
    hanged_status: game.hanged_status,
    secret_word: game.show_word,
    hidden: hidden
  }
end

get '/guess' do
  session[:game].make_guess(params['guess'])
  redirect('/')
end

get '/new' do
  session[:game] = HangmanApi.new
  redirect('/')
end
