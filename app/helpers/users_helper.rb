module UsersHelper
  # def normalize_name
    # implement on recipe names & ingredient names

  def ci_lower_bound(pos, n, confidence)
    if n == 0
        return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

  def api_call
    # search_term = current_user.
    search = "main" # "Bourbon and Ginger".gsub(" ", "+")
    # max_result = 1000
    api_id = "1ee7c15f"
    api_key = "e0bc4464448f7383d9550fdd47fea9a3"
    response = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id=#{api_id}&_app_key=#{api_key}&q=#{search}")
    
    @foods = response["matches"]
    @food = @foods.sample

    @ingredients = @food["ingredients"].map { |ingredient| ingredient.downcase }

    @food
  end

  def food_in_db?(food)
    @food = food
    PlaylistFood.all.any? { |playlist_food| playlist_food.name.downcase == @food["recipeName"].downcase }
  end

  def generate_food
    api_call

    # generates unique food not already in PlaylistFood
    while food_in_db?(@food)
      api_call
    end

    @food
  end

  def insert_food_into_db(food_instance)
    # create playlist_food
    playlist_food = PlaylistFood.create(name: food_instance["recipeName"], image_url: food_instance["smallImageUrls"].first)

    # establish playlist_food user relation
    current_user.playlist_foods << playlist_food
  end

  def insert_ingredients_into_db()
    # check if ingredient unique
      # if unique, create
  end

end