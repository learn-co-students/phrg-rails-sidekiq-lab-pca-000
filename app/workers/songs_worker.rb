class SongsWorker
  require "csv"
  include Sidekiq::Worker

  def perform(file)
    CSV.foreach(file, headers: true) do |song|
      new_song = Song.create(title: song[0])
      new_artist = Artist.find_or_create_by(name: song[1])
      new_song.artist = new_artist
      new_artist.songs << new_song
    end
  end
end
