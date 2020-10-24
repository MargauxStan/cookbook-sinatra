require_relative 'recipe'
require_relative 'cookbook'
require_relative 'scraper'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))

get '/new' do
  erb :new
end

get '/delete/:index' do
  @recipes = cookbook.all
  index = params[:index].to_i
  cookbook.remove_recipe(index)
  redirect '/'
end

get '/add/:index' do
  scraper = Scraper.new(params[:ingredient])
  @array = scraper.call
  index = params[:index].to_i
  recipe = @array[index]
  cookbook.add_recipe(recipe)
  redirect '/'
end

post '/recipe' do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:duration])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/' do
  @recipes = cookbook.all
  erb :index
end

post '/scrape' do 
  scraper = Scraper.new(params[:ingredient])
  @array = scraper.call
  erb :scrape
end