
class PostgameStories::Scraper
  SPORTS_NAMES = ["NFL", "NBA", "NHL","SOCCER", "TENNIS", "OLYMPICS", "GOLF", "BOXING", "WRESTLING", "HORSE RACING"]

   def self.scrape_menu(sports_url)
      doc = Nokogiri::HTML(open(sports_url))

        doc.css('nav.menu ul li a').each do |sport|
        sports_name = sport.attribute("href").text.split("/").last.upcase

        if SPORTS_NAMES.include? sports_name
          sports = PostgameStories::Sports.new
            sports.name = sports_name
            sports.sport_url = sport.attribute("href").text
          sports.save
        end

      end
  end

  def self.scrape_stories_details(sports_url)
    doc1 = Nokogiri::HTML(open(sports_url))

      doc1.css('div.item-list ul li').each do |story|

        stories  = PostgameStories::Stories.new
          stories.title = story.css("h2").text
          stories.description = story.css("p").text
          stories.link = story.css("span").text
        stories.save
      end
  end

end 
