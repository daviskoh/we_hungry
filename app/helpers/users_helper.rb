module UsersHelper
  # notes ###########################################

  # def normalize_name
    # implement on recipe names & ingredient names
  # def name_too_long
    # implement for display in User show page

  ###################################################

  # use to rank ingredients #######################

  def ci_lower_bound(pos, n, confidence)
    if n == 0
        return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

  ###################################################

  # basic connect to api & retrieve basic food ######

  def api_call
    # search_term = current_user.
    search = "main" # "Bourbon and Ginger".gsub(" ", "+")
    max_result = 10000
    api_id = "9666efa3"
    api_key = "0173cf5aebdb452af9af01120ff44b4f"
    response = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id=#{api_id}&_app_key=#{api_key}&q=#{search}&maxResult=#{max_result}")
    # binding.pry
    
    @foods = response["matches"]
    @food = @foods.sample

    @ingredients = @food["ingredients"].map { |ingredient| ingredient.downcase }

    @food
  end

  def food_in_db?(food)
    PlaylistFood.all.any? { |playlist_food| playlist_food.name.downcase == @food["recipeName"].downcase }
  end  

  def get_food_from_api
    api_call

    # generates unique food not already in PlaylistFood
    while food_in_db?(@food)
      api_call
    end

    @food
  end

  ###################################################

  # dietary conditions ###############################

  def is_food_vege?(food)
    meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]

    !food["ingredients"].any? { |ing| meat.include?(ing) }
  end

  def food_meet_lactose?(food)
    dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }

    !food["ingredients"].any? { |ing| dairy.include?(ing) }
  end

  def is_food_vegan?(food)
    meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]
    dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }
    forbidden = meat.concat(dairy)

    !food["ingredients"].any? { |ing| forbidden.include?(ing) }
  end

  def food_meet_nut?(food)
    nuts = ["chestnut", "chestnuts", "pinenut", "pinenuts", "Almonds", "Almond", "Brazil Nuts", "Brazil Nuts", "Cacao", "Cashews", "Cashew", "Chestnuts", "Coconut", "Coconuts", "Hazelnuts", "Hazelnut", "Macadamia Nuts", "Macadamia", "Mixed Nuts", "Peanuts", "Peanut", "Pecans", "Pecan", "Pine Nuts", "Pine Nut", "Pistachios", "Pistachio", "Soy Nuts", "Soy Nut", "Sunflower Seeds", "Sunflower Seed", "Walnuts", "Walnut", "Raw Nuts", "Raw Nuts", "Organic Nuts", "Roasted Nuts", "Salted Nuts", "Seasoned Nuts", "Unsalted Nuts", "Pili Nuts", "Nut Butter", "Bulk Nuts", "Black Walnut", "Black Walnuts", "nut", "nuts" ].map! { |i| i.downcase }

    !food["ingredients"].any? { |ing| nuts.include?(ing) }
  end

  ###################################################

  # generate food meeting restrictions ##############

  def get_vegan_food
    get_food_from_api until is_food_vege?(@food)
  end

  def get_milkless_food
    get_food_from_api until food_meet_lactoselactose?(@food)
  end

  def get_vegan_food
    get_food_from_api until is_food_vegan?(@food)
  end

  def get_nutless_food
    get_food_from_api until food_meet_nut?(@food)
  end

  ###################################################  

  # generate food ###################################

  def generate_food
    if current_user.vege
      get_vegan_food
    elsif current_user.lactose
      get_milkess_food
    elsif current_user.vegan
      get_vegan_food
    elsif current_user.nut
      get get_nutless_food
    else
      get_food_from_api
    end
  end

  ###################################################

  # database insertion ###############################

  def insert_food_into_db(food)
    # create playlist_food
    playlist_food = PlaylistFood.create(name: food["recipeName"], image_url: food["smallImageUrls"].first)

    # establish playlist_food user relation
    current_user.playlist_foods << playlist_food
  end

  def ingredients_in_db?(ingredients_array)
    Ingredient.all.any? { |ing| ingredients_array.include?(ing.name) }
  end

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

  ###################################################

end