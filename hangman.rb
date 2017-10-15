require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'hangman/hangman_api.rb'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

get '/' do
  session[:hidden] ||= Hash.new('hidden')
  session[:game] ||= HangmanApi.new
  game = session[:game]

  erb :index, locals: {
    word_status: game.word_status,
    incorrect: game.incorrect_guesses,
    status: session[:hidden]
  }
end

get '/guess' do
  session[:game].make_guess(params['guess'].downcase)
  status_setter

  if session[:game].win?
    redirect('/win')
  elsif session[:game].lose?
    redirect('/lose')
  else
    redirect('/')
  end
end

get '/new' do
  session[:game] = HangmanApi.new
  session[:hidden] = Hash.new('hidden')
  redirect('/')
end

get '/win' do
  erb :win, locals: {
    secret_word: session[:game].show_word
  }
end

get '/lose' do
  erb :lose, locals: {
    secret_word: session[:game].show_word
  }
end

helpers do
  def status_setter
    session[:game].hanged_level.times do |num|
      session[:hidden][num] = ''
    end
  end
end
