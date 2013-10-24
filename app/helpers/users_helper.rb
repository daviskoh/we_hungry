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
    max_result = 10000
    api_id = "9666efa3"
    api_key = "0173cf5aebdb452af9af01120ff44b4f"
    response = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id=#{api_id}&_app_key=#{api_key}&q=#{search}&maxResult=#{max_result}")
    binding.pry
    
    @foods = response["matches"]
    @food = @foods.sample

    @ingredients = @food["ingredients"].map { |ingredient| ingredient.downcase }

    @food
  end

  def food_in_db?(food)
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

  def is_food_vege?(food)
    meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]

    !food["ingredients"].any? { |ing| meat.include?(ing) }
  end

  def generate_vege_food
    generate_food

    until is_food_vege?(@food)
      generate_food
    end

    @food
  end

  def insert_food_into_db(food)
    # create playlist_food
    playlist_food = PlaylistFood.create(name: food["recipeName"], image_url: food["smallImageUrls"].first)

    # establish playlist_food user relation
    current_user.playlist_foods << playlist_food
  end

  # def ingredient_in_db?(ingredients_array)
  #   ingredients_array
  #   Ingredient.all.any? { |ing| ingredients_array.include?(ing) }
  # end

  # def insert_ingredients_into_db(ingredients_array)
  #   # check if ingredient exist already
  #   unless ingredient_in_db?(ingredients_array)
  #     # if unique, create each ingredient in array
  #     ingredients_array.each do { |ing| Ingredient.create(name: ing.downcase) }
  #       # establish user ingredient relation
  # -------> HERE
  #   # if exist already
  #   else
  #     nil
  #   end
  # end

end