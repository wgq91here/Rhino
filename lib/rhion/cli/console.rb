# Reloads classes
def reload!
  Rhion.reload!
end

# Show applications
def applications
  puts "==== List of Mounted Applications ====\n\n"
  Rhion.mounted_apps.each do |app|
    puts " * %-10s mapped to      %s" % [app.name, app.uri_root]
  end
  puts
  Rhion.mounted_apps.map { |app| "#{app.name} => #{app.uri_root}" }
end

# Load apps
#Rhion.mounted_apps.each do |app|
#  puts "=> Loading Application #{app.app_class}"
#  app.app_obj.setup_application!
#end
