#!/usr/bin/env ruby
first = ARGV[0]
third = ARGV[1]
output = ARGV[2] || 'output.jpg'

meh = "disappointment.jpg"
woo = "euphoria.jpg"

command = "montage '#{first}' '#{meh}' '#{third}' '#{woo}' -background '#000000' -geometry '+0+0' -tile 1 '#{output}'"
puts command
system command
