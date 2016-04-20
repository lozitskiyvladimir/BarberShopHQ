#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true

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
	@c = Client.new
	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
	 	erb "<h2>Спасибо, вы записались!</h2>"
	 else
	 	@error = @c.errors.full_messages.first
	 	erb :visit
	 end
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

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end
