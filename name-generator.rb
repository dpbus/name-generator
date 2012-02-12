class NameGenerator
  def initialize(filename)
    read_files(filename)
  end

  def read_files(filename)
    @words = []
    File.open(filename, "r").each_line do |line|
      @words << line.chomp
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

ng = NameGenerator.new("example_keywords.txt")
ng.run
