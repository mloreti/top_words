#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

class Scraper
  def initialize(url, num)
    print_loading(url)
    fetch_data(url, num)
  end

  def fetch_data(url, num_words)
    list = []
    frequent_words = {}
    doc = Nokogiri::HTML(open(url))
    doc.search('p', 'h1', 'h2', 'h3').each do |text| 
      text.content.split(" ").each do |word|
        word = word.gsub(/[0-9]/i, '').downcase
        list.push(word) unless not_allowed(word)
      end
    end
    
    list.each do |word|
      frequent_words[word] = frequent_words[word].nil? ? 1 : frequent_words[word]+= 1
    end
    
    top_words = frequent_words.sort_by {|_key, value| value}.reverse.take(num_words)
    print_results(top_words, num_words)
  end

  def print_loading(url)
    puts "Fetching data from #{url}"
    20.times do |i|
      sleep 0.1
      print '-'
    end
    print "\n"
  end

  def print_results(words, num_words)
    divider = "--------------------"
    puts "--- TOP #{num_words} WORDS ---"
    puts divider
    
    words.each do |word, value|
      puts "- #{word}"
    end
    
    3.times { puts divider }
  end

  def not_allowed(word)
    blacklist = ["redazione", "cura", "datasport"]
    word.empty? || 
    word.start_with?("http") || 
    word.to_i > 0 ||
    word == "–" ||
    blacklist.include?(word)
  end
end