require 'yaml'

ARGV.each_with_index do |x,i|
      "ARGV[#{i}] = #{x.inspect}"
end
if ARGV[1] == "mainpath" then
    puts YAML.load(open(ARGV[0]).read)[ARGV[1]]
else
    puts YAML.load(open(ARGV[0]).read)[ARGV[1]]["urls"]
end
