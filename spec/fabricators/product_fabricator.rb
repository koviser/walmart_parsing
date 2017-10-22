Fabricator(:product, class_name: Product) do
  # Attributes
  # --------------------------------------------------
  name               { Faker::Name.name }
  url                { 'https://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789' }
  us_item_id         { Faker::Name.name }
  product_id         { Faker::Name.name }
  price              { rand(1000) }
  price_min          { rand(1000) }
  price_min_currency { '$' }
  price_max          { rand(1000) }
  price_max_currency { '$' }
end
