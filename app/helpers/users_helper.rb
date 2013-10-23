module UsersHelper
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

    @food
  end
end