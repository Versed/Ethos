desc "Import avatars from a user's gravatar url"
task :import_avatars => :environment do
  puts "importing avatars from gravatar"
  User.get_gravatars
  puts "avatars imported"
end
