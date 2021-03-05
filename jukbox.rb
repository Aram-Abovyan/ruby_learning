class WordIndex
  def initialize
    @index = Hash.new(nil)
  end

  def index(anObject, *phrases)
    phrases.each do |aPhrase|
      aPhrase.scan(/\w[-\w']+/) do |aWord|
        aWord.downcase!
        @index[aWord] = [] if @index[aWord].nil?
        @index[aWord].push(anObject)
      end
    end
  end

  def lookup(aWord)
    @index[aWord.downcase]
  end
end

class Song
  attr_reader :title, :name, :duration

  def initialize(title, name, duration)
    @title = title
    @name = name
    @duration = duration
  end

  def to_s
    "Title: #{title}\nName: #{name}\nDuration: #{duration}"
  end
end

class SongList
  def initialize
    @songs = Array.new
    @index = WordIndex.new
  end

  def [](key)
    return @songs[key] if key.kind_of?(Integer)
    return @songs.find { |aSong| key == aSong.title }
  end

  def append(aSong)
    @songs.push(aSong)
    @index.index(aSong, aSong.name, aSong.title)
    self
  end

  def deleteFirst
    @songs.shift
  end

  def deleteLast
    @songs.pop
  end

  def lookup(aWord)
    @index.lookup(aWord)
  end

  def to_s
    self.inspect
  end
end

songs = SongList.new

songsFile = File.open("./songs")
songsFile.each do |line|
  file, length, name, title = line.chomp.split(/\s*\|\s*/)

  name.squeeze!(' ')

  mins, secs = length.scan(/\d+/)

  songs.append(Song.new(title, name, mins.to_i*60+secs.to_i))
end

puts songs.lookup("Fats")
puts songs.lookup("ain't")
puts songs.lookup("RED")
puts songs.lookup("WoRlD")