#!/usr/bin/env ruby
$doc = <<ENDDOC
name-generator.rb - Print all 2 word combinations from a file of keywords.

SYNOPSIS
name-generator.rb [options] keyword-filenames

DESCRIPTION
Given one or more files of keywords (one keyword on each line), this script will print out all possible 2 word combinations.

OPTIONS
  -h, --help
  Print this help and exit.
ENDDOC

require 'getoptlong'

class NameGenerator
  def initialize(filenames)
    read_files(filenames)
  end

  def read_files(filenames)
    @words = []

    filenames.each do |f|
      File.open(f, "r").each_line do |line|
        word = line.chomp
        @words << word unless @words.include?(word)
      end
    end
  end

  def run
    @words.each do |w1|
      @words.each do |w2|
        puts "#{titleize(w1)}#{titleize(w2)}" unless w1 == w2
      end
    end
  end

  def titleize(str)
    str.split(/(\W)/).map(&:capitalize).join
  end
end

def check_options
  opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ])

  opts.quiet = true

  opts.each do |opt, arg|
    case opt
    when '-h', '--help'
      usage
      exit
    end
  end
end

def get_args
  if ARGV.length < 1
    puts "Wrong number of arguments.\n\n"
    usage
    exit 1
  end
  ARGV
end

def usage
  puts $doc
end


if __FILE__ == $0

  check_options

  filenames = get_args

  errors = []
  filenames.each do |f|
    if !File.file? f
      errors << "No such file - #{f}"
    end
  end

  unless errors.empty?
    puts errors.join("\n")
    exit 1
  end

  generator = NameGenerator.new(get_args)
  generator.run
end
