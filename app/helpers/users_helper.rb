module UsersHelper

  # make easier to read for users ##################

  def better_capitalize(string)
    forbidden = %w{the and in of con a with}

    a = string.capitalize.split(" ")

    @title = a.map do |word|
      forbidden.include?(word) ? word : word.capitalize
    end

    @title.join(" ")
  end

  def normalize(food_name)
    unnecessary_words = ["book", "independence", "cookbook", "master", "fresh", "thanksgiving", "die", "addictive", "holiday", "oven", "homemade", "fast", "like", "stovetop", "perfect", "special", "fiesta", "best", "basic", "carpet", "simple", "friday", "night", "how", "make", "the", "crust", "crustless", "recipe", "really", "two", "three", "four", "world\'s", "last-minute", "minute", "minutes", "1-2-3", "cook", "lunch", "breakfast", "dinner", "tonight", "emeril\'s", "awesome", "awesomely", "easy", ",", ":", "you", "will", "ever", "last", "for", "need", ".", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "in minutes", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"].map! { |l| l.downcase }

    food_data = food_name.downcase

    # remove unnecessary words
    unnecessary_words.each do |word|
      food_data.gsub!(word, "")
    end

    # if name begin with "and", remove
    if food_data.split(" ")[0] == "and"
      food_data.sub!("and", "")
    end

    # regex, remove awkward whitespace then capitalize
    food = food_data.gsub(/\s{2,}/, " ").strip.capitalize

    better_capitalize(food)
  end

  # def name_too_long
    # implement for display in User show page

  ###################################################

  # get api data ####################################

  # def food_in_db?(food)
  #   PlaylistFood.all.any? { |playlist_food| playlist_food.name.downcase == food.name.downcase }
  # end  

  # def api_call
  # end

  # def get_food_from_api
  #   api_call

  #   # generates unique food not already in PlaylistFood
  #   while food_in_db?(@food)
  #     api_call
  #   end

  #   @food
  # end

  ###################################################

  # get food ########################################

  def pull_food_from_db
    @food = PlaylistFood.all.sample
  end

  ###################################################

  # dietary conditions ###############################

  def is_food_vege?(food)
    meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]

    !food["ingredients"].any? { |ing| meat.include?(ing) }
  end

  def is_dairy_free?(food)
    dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }

    !food["ingredients"].any? { |ing| dairy.include?(ing) }
  end

  def is_food_vegan?(food)
    meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]
    dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }
    forbidden = meat.concat(dairy)

    !food["ingredients"].any? { |ing| forbidden.include?(ing) }
  end

  def is_nutless?(food)
    nuts = ["chestnut", "chestnuts", "pinenut", "pinenuts", "Almonds", "Almond", "Brazil Nuts", "Brazil Nuts", "Cacao", "Cashews", "Cashew", "Chestnuts", "Coconut", "Coconuts", "Hazelnuts", "Hazelnut", "Macadamia Nuts", "Macadamia", "Mixed Nuts", "Peanuts", "Peanut", "Pecans", "Pecan", "Pine Nuts", "Pine Nut", "Pistachios", "Pistachio", "Soy Nuts", "Soy Nut", "Sunflower Seeds", "Sunflower Seed", "Walnuts", "Walnut", "Raw Nuts", "Raw Nuts", "Organic Nuts", "Roasted Nuts", "Salted Nuts", "Seasoned Nuts", "Unsalted Nuts", "Pili Nuts", "Nut Butter", "Bulk Nuts", "Black Walnut", "Black Walnuts", "nut", "nuts" ].map! { |i| i.downcase }

    !food["ingredients"].any? { |ing| nuts.include?(ing) }
  end

  ###################################################

  # generate food meeting restrictions ##############

  def get_vegan_food
    # get_food_from_api until is_food_vege?(@food)
    pull_food_from_db until is_food_vege?(@food)
  end

  def get_dairy_free_food
    # get_food_from_api until is_dairy_free?(@food)
    pull_food_from_db until is_dairy_free?(@food)
  end

  def get_vegan_food
    # get_food_from_api until is_food_vegan?(@food)
    pull_food_from_db until is_food_vegan?(@food)
  end

  def get_nutless_food
    # get_food_from_api until is_nutless?(@food)
    pull_food_from_db until is_nutless?(@food)
  end

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

  # generate food ###################################

  def generate_food
    if current_user.vege
      get_vegan_food
    elsif current_user.lactose
      get_milkess_food
    elsif current_user.vegan
      get_vegan_food
    elsif current_user.nut
      get_nutless_food
    else
      # get_food_from_api
      pull_food_from_db
    end
  end

  ###################################################

  # database insertion ###############################

  def add_to_user_foodlist(food)
    # create playlist_food
    # playlist_food = PlaylistFood.create(name: food["recipeName"], image_url: food["smallImageUrls"].first)

    # establish playlist_food user relation
    current_user.playlist_foods << food
  end

  # def ingredient_in_db?(ingredient)
  #   Ingredient.all.any? { |ing| ing.name.downcase == ingredient.downcase }
  # end

  def user_has_ingredient?(ingredient)
    current_user.ingredients.include?(ingredient)
  end

  # def food_has_ingredient?(food, ingredient)
  #   food.ingredients.include?(ingredient)
  # end

  def add_to_user_ingredients(ingredient)
    current_user.ingredients << ingredient
  end

  # def insert_ingredients_into_db(ingredients_array)
  #   ingredients_array.each do |ing|
  #     Ingredient.create(name: ing.downcase) unless ingredient_in_db?(ing)
  #     # establish user relation
  #     add_to_user_ingredients(ing)
  #   end
  # end

  ###################################################

end