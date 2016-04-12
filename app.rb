#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end

before do
	@barbers = Barber.all
end

get '/' do
	@barbers = Barber.all
	 erb :index

end

get '/visit' do

	erb :visit
end

post '/visit' do

	@username   = params[:username]
	@phone  = params[:phone]
	@datetime   = params[:datetime]
	@barber = params[:master]
	@color  = params[:color]

	Client.create :name => @username, :phone => @phone, :datestamp => @datetime, :barber => @barber, :color => @color
	
		
	
	erb "#{@username}, #{@phone},#{@datetime}, #{@barber}, #{@color}"
end
get '/contacts' do
  "Hello World"
end