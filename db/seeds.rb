CATEGORIES = %w[Cleanliness Responsibility Sociability]

puts "Creating categories -- these ALWAYS have to be hardwired in"

CATEGORIES.each { |cat| Category.create(name: cat )}
