class PostgameStories::Stories
  attr_accessor :title, :description, :link

  @@stories = []

  def save
    @@stories << self
  end

  def self.all
    @@stories
  end

  def self.destroy
    @@stories = []
  end

end 
