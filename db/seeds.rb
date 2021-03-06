# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

Dir[Rails.root.join('./db', 'seeds', '*.rb').to_s].each do |file|
  puts "Loading db/seeds/#{file.split(File::SEPARATOR).last}"
  load(file)
end

# Added by Refinery CMS Crpvs extension
Refinery::Crpvs::Engine.load_seed

# Added by Refinery CMS Projets engine
Refinery::Projets::Engine.load_seed

# Added by Refinery CMS News engine
Refinery::News::Engine.load_seed

# Added by Refinery CMS Documents extension
Refinery::Documents::Engine.load_seed

# Added by Refinery CMS Enquetes extension
Refinery::Enquetes::Engine.load_seed
