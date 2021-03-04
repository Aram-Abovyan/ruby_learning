class Song
  attr_reader :name, :artist, :duration

  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
  end

  def to_s
    "Name: #{name}\nArtist: #{artist}\nDuration: #{duration}"
  end
end

class SongList
  def initialize
    @songs = Array.new
  end

  def [](key)
    return @songs[key] if key.kind_of?(Integer)
    return @songs.find { |aSong| key == aSong.name }
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

list = SongList.new

list.
  append(Song.new('Name1', 'Artist1', 1)).
  append(Song.new('Name2', 'Artist2', 2)).
  append(Song.new('Name3', 'Artist3', 3)).
  append(Song.new('Name4', 'Artist4', 4))

puts list