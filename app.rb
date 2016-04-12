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

class Contact < ActiveRecord::Base

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

	# Client.create :name => @username, :phone => @phone, :datestamp => @datetime, :barber => @barber, :color => @color
	c = Client.new
	c.name = @username
	c.phone = @phone
	c.datestamp = @datetime
	c.barber = @barber
	c.color = @color	
	c.save
	 # erb "#{@username}, #{@phone},#{@datetime}, #{@barber}, #{@color}"
	 erb "Вы записались"
end
get '/contacts' do
 	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@text  = params[:text]

	 Contact.create :email => @email, :text => @text
	

	erb :contacts
	# erb "#{@email}, #{@text}"
end











