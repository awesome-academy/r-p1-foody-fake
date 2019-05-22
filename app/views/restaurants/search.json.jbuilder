json.array!(@restaurants) do |restaurant|
  json.name restaurant.title
  json.location restaurant.location
  json.image restaurant.image
end
