CATEGORIES = %w[Cleanliness Responsibility Sociability]

puts "Creating categories -- these ALWAYS have to be hardwired in"

CATEGORIES.each { |cat| Category.find_or_create_by_name(cat)}


