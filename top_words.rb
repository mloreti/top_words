#! /usr/bin/env ruby
require_relative 'scraper.rb'

def get_top_words
  max = 50
  site = get_site

  puts "How many top words would you like?"

  number_of_words = get_number(max)

  while number_of_words < 1 || number_of_words > max
    number_of_words = get_number
  end

  Scraper.new(site, number_of_words)
end

def get_number(max)
  puts "Please enter a number between 1-#{max}"
  print ">> "
  gets.chomp.to_i
end

def get_site
  options = [
    {
      name: 'il sole 24 ore',
      url: 'http://www.ilsole24ore.com'
    },
    {
      name: 'la repubblica',
      url: 'http://www.repubblica.it'
    },
    {
      name: 'il messagero',
      url: 'https://www.ilmessaggero.it'
    }
  ]
  puts "Choose a site"

  options.each_with_index do |site, i|
    puts "#{i+1}: #{site[:name]}"
  end
  
  site = get_number(options.length)
  
  while site < 1 || site > options.length
    site = get_number(options.length)
  end
  
  site = site.to_i - 1
  options[site][:url]
end

get_top_words