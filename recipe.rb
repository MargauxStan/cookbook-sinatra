class Recipe
    attr_reader :name, :description, :rating, :duration
  
    def initialize(name, description, rating, duration, done = false)
      @name = name
      @description = description
      @rating = rating
      @duration =  duration
      @done = done
    end
  
    def done?
      @done
    end
  
    def done!
      @done = true
    end
  end
  