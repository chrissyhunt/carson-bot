Location.all.each do |location|
  location.admin_lock = true
  location.save
end

Category.all.each do |category|
  category.admin_lock = true
  category.save
end
