class PostgameStories::Stories
  attr_accessor :title, :description, :link, :sport

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

  # refactor - find by sport name
  def self.find_by_sport(sporturl)
      sport = sporturl.split('/').last.upcase
      @@stories.select do |story|
        if story.sport == sport
          true
        end
      end

    end
end
