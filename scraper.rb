require_relative 'recipe'
require 'nokogiri'
require 'open-uri'

class Scraper 
    def initialize(keyword)
      @keyword = keyword
    end
  
    def call
      # TODO: return a list of `Recipes` built from scraping the web.
      @file = open("https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@keyword}").read
      import_elements
      return create_recipes
    end

    def import_elements
      @doc = Nokogiri::HTML((@file), nil, 'utf-8')
      @names = []
      @descriptions = []
      @ratings =[]
      @durations = []
      @doc.search('.recipe-card__description').first(5).each { |element| @descriptions << element.text.strip }
      @doc.search('.recipe-card__rating__score').first(5).each { |element| @ratings << element.text.strip }
      @doc.search('.recipe-card__duration__value').first(5).each { |element| @durations << element.text.strip }
      @doc.search('.recipe-card__title').first(5).each { |element| @names << element.text.strip }
    end

    def create_recipes
      array = []
      for i in 0..4 do 
        array  << Recipe.new(@names[i], @descriptions[i], @ratings[i], @durations[i])
      end
      return array
    end

  end  