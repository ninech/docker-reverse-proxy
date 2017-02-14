require 'erb'
require 'ostruct'

template    = File.read('vhost.conf.erb')
target_path = '/tmp/httpd.conf'

File.write target_path, ERB.new(template, nil, '-').result

puts "Wrote VHost configuration:\n"
puts File.read(target_path)
