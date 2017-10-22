Fabricator(:review, class_name: Review) do
  # Attributes
  # --------------------------------------------------
  author_id       { Faker::Name.name }
  rating          { Faker::Name.name }
  review_id       { Faker::Name.name }
  submission_time { Faker::Name.name }
  text            { Faker::Name.name }
  title           { Faker::Name.name }
  user_nickname   { Faker::Name.name }
end

Fabricator(:review_with_assoc, from: :review) do
  product { Fabricate(:product) }
end

