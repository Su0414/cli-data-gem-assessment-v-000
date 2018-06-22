class PostgameStories::Sports
  attr_accessor :name, :sport_url

  @@sports = []

  def save
    @@sports << self
  end

  def self.all
    @@sports
  end

  def self.destroy
    @@sports = []
  end

end 
