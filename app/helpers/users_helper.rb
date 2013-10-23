module UsersHelper
  def ci_lower_bound(pos, n, confidence)
    if n == 0
        return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

  def api_call
    search = "" #.gsub(" ", "+")
      # max_result = 1000
    api_id = "1ee7c15f"
    api_key = "e0bc4464448f7383d9550fdd47fea9a3"
    response = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id=#{api_id}&_app_key=#{api_key}&q=#{search}")

    @foods = response["matches"]
    @food = @foods.sample

    @meat = ["bacon","beef","bushmeat","chicken","crab","crabmeat","dark meat","duck","goose","ground beef","horseflesh","lamb","lean","meat","meatball","mince","mincemeat","mutton","partridge","pheasant","pork","poultry","quail","rabbit","stewing steak", "steak", "streaky bacon", "sausage","turkey","veal","venison","white meat","white meat","wild boar"]
    @dairy = []
    @nuts = []

    sorted_ingredients = current_user.ingredients.sort_by do |ing|
      # positive votes, total votes, 95% confidence interval
      self.ci_lower_bound(ing.pos_vote, ing.tot_vote, 0.95)
    end
    food_needs = sorted_ingredients[0..2]

    until food_needs.all? { |ing| @food["ingredients"].include?(ing) }
      if current_user.vege
        while @food["ingredients"].any? { |ing| @meat.include?(ing) }
          @food = @foods.sample
        end
      elsif current_user.lactose
        while @food["ingredients"].any? { |ing| @dairy.include?(ing) }
          @food = @foods.sample
        end
      elsif current_user.nut
        while @food["ingredients"].any? { |ing| @nut.include?(ing) }
          @food = @foods.sample
        end
      elsif current_user.vegan
        while @food["ingredients"].any? { |ing| @meat.concat(@dairy).include?(ing) }
          @food = @foods.sample
        end
      else
        nil
      end
    end

    @food
  end
end