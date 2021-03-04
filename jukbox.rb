class Song
  attr_reader :name, :artist, :duration

  def initialize(title, name, duration)
    @title = title
    @name = name
    @duration = duration
  end

  def to_s
    "Title: #{title}\nName: #{artist}\nDuration: #{duration}"
  end
end

class SongList
  def initialize
    @songs = Array.new
  end

  def [](key)
    return @songs[key] if key.kind_of?(Integer)
    return @songs.find { |aSong| key == aSong.title }
  end

  def append(aSong)
    @songs.push(aSong)
    self
  end

  def deleteFirst
    @songs.shift
  end

  def deleteLast
    @songs.pop
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
  songs.append(Song.new(title, name, length))
end

puts songs