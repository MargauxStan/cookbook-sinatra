require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @filepath = csv_file_path
    load_csv
  end

  def load_csv
    CSV.foreach(@filepath) do |row|
      name = row[0]
      description = row[1]
      rating = row[2]
      duration = row[3]
      done = row[4] == "true"
      @recipes << Recipe.new(name, description, rating, duration, done)
    end
  end

  def all
    return @recipes
  end

  def save_csv
    CSV.open(@filepath, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.duration, recipe.done?]
      end
    end
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end
end
