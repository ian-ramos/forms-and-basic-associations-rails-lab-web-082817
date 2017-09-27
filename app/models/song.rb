class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.try(:artist).try(:name) # .try will that method and if it fails, then it will return nil instead of a no method error (can't execute method on nil).  You can't do self.artist.name b/c the form will call on the getter method to find the artist, which will throw an error if the artist doesn't exist
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.try(:genre).try(:name)
  end

  def note_contents=(contents)
    array = contents.reject { |content| content.empty? }
    array.each do |content|
      note = Note.create(content: content)
      self.notes << note
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content
    end
  end

end
