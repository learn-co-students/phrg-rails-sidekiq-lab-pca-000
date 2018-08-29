class SongsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(songs_file)
    CSV.foreach(leads_file, headers: true) do |song|
      Song.create(title: song[0], artist_name: song[1])
    end
  end
end
