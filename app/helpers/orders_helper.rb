module OrdersHelper
  def get_order_id
    cookies.signed[:order_id]
  end

  def get_name_from_hash array
    return array[0]
  end

  def get_image_from_hash array
    return array[1].url
  end
end
