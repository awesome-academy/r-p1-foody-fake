module OrderDetailHelper
  def get_price food_id
    Food.find_by(id: food_id).price
  end
end
