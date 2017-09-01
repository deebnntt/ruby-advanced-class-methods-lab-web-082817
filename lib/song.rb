require 'pry'

class Song

  attr_accessor :name, :artist_name

  @@all = []

  def self.all
    @@all
  end

  def self.create
    @@all << self.new
    @@all[-1]
  end

  def self.new_by_name(song_name)
    song = self.new
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    song = self.new
    song.name = song_name
    song
    song.save
    @@all[-1]
  end

  def self.find_by_name(song)
    @@all.detect{|name| name.name == song}
  end

  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name) == nil
      self.create_by_name(song_name)
    else
      self.find_by_name(song_name)
    end
  end

  def self.alphabetical
    self.all.sort_by { |songs | songs.name }
  end

  def self.new_from_filename(filename)
    data = filename.split(" - ")
    artist_name = data[0].to_s
    title_and_mp3 = data[1]
    data2 = title_and_mp3.split(".")
    song_name = data2[0].to_s
    new_song = self.new(song_name, artist_name)
    new_song
  end

  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
  end

  def self.destroy_all
    @@all.clear
  end

  def initialize(name = nil, artist_name = nil)
    @name = name
    @artist_name = artist_name
  end

  def save
    self.class.all << self
  end

end
