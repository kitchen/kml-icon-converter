#!/usr/bin/env ruby

require 'csv'

input_filename = ARGV[0]
output_filename = ARGV[1]

input_file = File.open(input_filename, 'r')
output_file = File.open(output_filename, 'w')

style_map = {}
CSV.foreach('style_map.csv') do |row|
  google_style_url = row[0]
  if google_style_url
    style_map[google_style_url] = row[3]
    puts google_style_url, row[3]
  end
end

input_file.each do |line|
  if matches = line.match(%r{\<styleUrl\>#?(?<style_url>.*?)(-nodesc)?\</styleUrl\>})
    style_url = matches[:style_url]
    puts style_url
    if new_style = style_map[style_url]
      line.gsub!(%r{\>#?(.*)\</}, ">##{new_style}</")
      puts line
    end
  end
  output_file.puts line
end
