require 'yaml'

ARGV.each_with_index do |x,i|
      "ARGV[#{i}] = #{x.inspect}"
end
puts YAML.load(open(ARGV[0]).read)[ARGV[1]]["urls"]
