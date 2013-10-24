module UsersHelper
  # def normalize_name
    # implement on recipe names & ingredient names

  # def ci_lower_bound(pos, n, confidence)
  #   if n == 0
  #       return 0
  #   end
  #   z = Statistics2.pnormaldist(1-(1-confidence)/2)
  #   phat = 1.0*pos/n
  #   (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  # end

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
##############

  def get_food_recommendation
    # @meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]
    # @dairy = ["Acidophilus Milk", "Ammonium Caseinate", "Butter", "Butter Fat", "Butter Oil", "Butter Solids", "Buttermilk", "Buttermilk Powder", "Calcium Caseinate", "Casein", "Caseinate (in general)", "Cheese (All animal-based)", "Condensed Milk", "Cottage Cheese", "Cream", "Curds", "Custard", "Delactosed Whey", "Demineralized Whey", "Dry Milk Powder", "Dry Milk Solids", "Evaporated Milk", "Ghee (see p109)", "Goat Milk", "Half & Half", "Hydrolyzed Casein", "Hydrolyzed Milk Protein", "Iron Caseinate", "Lactalbumin", "Lactoferrin", "Lactoglobulin", "Lactose", "Lactulose", "Low-Fat Milk", "Magnesium Caseinate", "Malted Milk", "Milk", "Milk Derivative", "Milk Fat", "Milk Powder", "Milk Protein", "Milk Solids", "Natural Butter Flavor", "Nonfat Milk", "Nougat", "Paneer", "Potassium Caseinate", "Pudding", "Recaldent", "Rennet Casein", "Skim Milk", "Sodium Caseinate", "Sour Cream", "Sour Milk Solids", "Sweetened Condensed Milk", "Sweet Whey", "Whey", "Whey Powder", "Whey Protein Concentrate", "Whey Protein Hydrolysate", "Whipped Cream", "Whipped Topping", "Whole Milk", "Yogurt", "Zinc Caseinate"].map! { |i| i.downcase }
    # @nuts = ["Almonds", "Brazil Nuts", "Cacao", "Cashews", "Chestnuts", "Coconut", "Hazelnuts", "Macadamia Nuts", "Mixed Nuts", "Peanuts", "Pecans", "Pine Nuts", "Pistachios", "Soy Nuts", "Sunflower Seeds", "Walnuts", "No Mess Nut Cracker", "Chocolates & Sweets", "Raw Nuts", "Organic Nuts", "Roasted Nuts", "Salted Nuts", "Seasoned Nuts", "Unsalted Nuts", "Pili Nuts", "Nut Butters & Oils", "Bulk Nuts", "Black Walnut" ].map! { |i| i.downcase }

    # sorted_ingredients = current_user.ingredients.sort_by do |ing|
    #   # positive votes, total votes, 95% confidence interval
    #   ci_lower_bound(ing.pos_vote, ing.tot_vote, 0.95)
    # end
    # food_needs = sorted_ingredients[0..2]

    @food = api_call

    while PlaylistFood.any? { |food| food.name.downcase == @food["recipeName"].downcase }
      @food = api_call
      # until retrieve unique food
      # until food_needs.all? { |ing| @ingredients.include?(ing) }
      #   while current_user.playlist_foods.include?(@food["recipeName"])
      #     if current_user.vege
      #       while @ingredients.any? { |ing| @meat.include?(ing) }
      #         @food = @foods.sample
      #       end
      #     elsif current_user.lactose
      #       while @ingredients.any? { |ing| @dairy.include?(ing) }
      #         @food = @foods.sample
      #       end
      #     elsif current_user.nut
      #       while @ingredients.any? { |ing| @nut.include?(ing) }
      #         @food = @foods.sample
      #       end
      #     elsif current_user.vegan
      #       while @ingredients.any? { |ing| @meat.concat(@dairy).include?(ing) }
      #         @food = @foods.sample
      #       end
      #     else
      #       nil
      #     end
      #   end
      # end
    end

    @food
  end

  def insert_api_call_to_db
    # unless food already exists in playlist_foods table
      # create playlist_food
      @playlist_food = PlaylistFood.create(name: @food["recipeName"], image_ur: @food["smallImageUrls"])
      # prevent duplicate entries
      unless current_user.playlist_foods.any? { |food| @food["recipeName"] }
        # find playlist_food
        @playlist_food = PlaylistFood.find_by(name: @food["recipeName"])
      end

    # associate w/ current user
    current_user.playlist_foods << @playlist_food unless @playlist_food.nil?

    @ingredients.each do |ing|
      unless Ingredient.all.any? { |i| i.name == ing.downcase }
        # create ingredient
        @ingredient = Ingredient.create(name: ing.downcase)
      else
        # find ingredient
        @ingredient = Ingredient.find_by(name: ing)
      end

      # before this
      playlist_food = PlaylistFood.where(name: @food["recipeName"])[0]
      playlist_food.ingredients << @ingredient
    end
  end
end