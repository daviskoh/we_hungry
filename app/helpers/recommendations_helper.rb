module RecommendationsHelper
  #TODO test normalize method
  #TODO change to sql

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
    food_data.split(/\W+/).each do |w|
      food_data.gsub!(/\w+/) { |word| unnecessary_words.include?(word) ? '' : word }
    end

    # if name begin with "and", remove
    if food_data.split(" ")[0] == "and"
      food_data.sub!("and", "")
    end

    # regex, remove awkward whitespace then capitalize
    food = food_data.gsub(/\s{2,}/, " ").strip.capitalize

    better_capitalize(food)
  end

  def make_concise(word)
    word.sub(word[-28..-1],"...")
  end

  # def name_too_long
    # implement for display in User show page

  ###################################################

  # get food ########################################

  def pull_food_from_db
    PlaylistFood.order("random()").first
  end

  ###################################################

  # dietary conditions ###############################

  def is_food_vege?(food)
    meats = ["meatball", "tuna", "fish", "bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar", "Anchovy", "Basa", "Bass", "Black cod", "Sablefish", "Bluefish", "Bombay duck", "Butter fish", "Blowfish", "Bream", "Brill", "Catfish", "Cod", "Dogfish", "Dorade", "Eel", "Flounder", "Grouper", "Haddock", "Halibut", "Herring", "Ilish", "John Dory", "Kingfish", "Lamprey", "Lingcod", "Mackerel", "Mahi Mahi", "Monkfish", "Mullet", "Orange roughy", "Patagonian toothfish", "Pike", "Pollock", "Pomfret", "Pompano", "Sablefish", "Sanddab", "Sardine", "Salmon", "Sea bass", "Shad", "Shark", "Skate", "Snakehead", "Snapper", "Sole", "Sturgeon", "Surimi", "Swordfish", "Tilapia", "Tilefish", "Trout", "Tuna", "Turbot", "Wahoo", "Whitefish", "Whiting"].map! { |i| i.downcase }

    # !food.ingredients.any? { |ing| meat.include?(ing.name.downcase) }
    food.ingredients.each do |ing|
      @result = !meats.any? { |meat| ing.name.include?(meat) }
    end

    @result
  end

  # def is_dairy_free?(food)
  #   dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }

  #   !food.ingredients.any? { |ing| dairy.include?(ing.name.downcase) }
  # end

  # def is_food_vegan?(food)
  #   meats = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]
  #   dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }
  #   forbidden = meats.concat(dairy)
  #   !food.ingredients.any? { |ing| forbidden.include?(ing.name.downcase) }
  # end

  # def is_nutless?(food)
  #   nuts = ["chestnut", "chestnuts", "pinenut", "pinenuts", "Almonds", "Almond", "Brazil Nuts", "Brazil Nuts", "Cacao", "Cashews", "Cashew", "Chestnuts", "Coconut", "Coconuts", "Hazelnuts", "Hazelnut", "Macadamia Nuts", "Macadamia", "Mixed Nuts", "Peanuts", "Peanut", "Pecans", "Pecan", "Pine Nuts", "Pine Nut", "Pistachios", "Pistachio", "Soy Nuts", "Soy Nut", "Sunflower Seeds", "Sunflower Seed", "Walnuts", "Walnut", "Raw Nuts", "Raw Nuts", "Organic Nuts", "Roasted Nuts", "Salted Nuts", "Seasoned Nuts", "Unsalted Nuts", "Pili Nuts", "Nut Butter", "Bulk Nuts", "Black Walnut", "Black Walnuts", "nut", "nuts" ].map! { |i| i.downcase }

  #   !food.ingredients.any? { |ing| nuts.include?(ing.name.downcase) }
  # end

  ###################################################

  # generate food meeting restrictions ##############

  def get_vege_food
    # get_food_from_api until is_food_vege?(@food)
    pull_food_from_db until is_food_vege?(pull_food_from_db)
  end

  def get_dairy_free_food
    # get_food_from_api until is_dairy_free?(@food)
    pull_food_from_db until is_dairy_free?(pull_food_from_db)
  end

  def get_vegan_food
    # get_food_from_api until is_food_vegan?(@food)
    pull_food_from_db until is_food_vegan?(pull_food_from_db)
  end

  def get_nutless_food
    # get_food_from_api until is_nutless?(@food)
    pull_food_from_db until is_nutless?(pull_food_from_db)
  end

  ###################################################  

  # use to rank ingredients #######################

  def ci_lower_bound(pos, total, confidence)
    if pos == 0
      return -(total - pos)
    end

    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = (1.0 * pos) / total
    (phat + z*z/(2*total) - z * Math.sqrt((phat*(1-phat)+z*z/(4*total))/total))/(1+z*z/total)
  end

  ###################################################

  # generate food ###################################

  def generate_food
    # if current_user.vege
    #   get_vege_food
    # elsif current_user.lactose
    #   get_milkess_food
    # elsif current_user.vegan
    #   get_vegan_food
    # elsif current_user.nut
    #   get_nutless_food
    # else
      # get_food_from_api
      pull_food_from_db
    # end
  end

  def gen_preferred_food
    #TODO fix redunency below
    ings = current_user.top_ingredients
    
    reco = generate_food until reco && reco.include_preferences?(ings)

    reco
  end

  ###################################################

  # database insertion ###############################

  def user_has_ingredient?(ingredient)
    current_user.ingredients.include?(ingredient)
  end

  def food_has_ingredient?(food, ingredient)
    food.ingredients.include?(ingredient)
  end

  ###################################################

end