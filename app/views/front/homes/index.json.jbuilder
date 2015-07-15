json.array!(@front_homes) do |front_home|
  json.extract! front_home, :id
  json.url front_home_url(front_home, format: :json)
end
