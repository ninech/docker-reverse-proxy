require 'erb'
require 'ostruct'

template    = File.read('vhost.conf.erb')
target_path = '/etc/apache2/sites-enabled/proxy.conf'

File.write target_path, ERB.new(template, nil, '-').result

puts "Wrote VHost configuration:\n"
puts File.read(target_path)
