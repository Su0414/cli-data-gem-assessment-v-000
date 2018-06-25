class PostgameStories::CLI
  BASE_PATH = "http://www.thepostgame.com/"

   def call
     puts "________________________________________________________".colorize(:green)
     puts "Welcome to The Postgame Stories".colorize(:green)
     puts "________________________________________________________".colorize(:green)
     main_menu
   end

   def main_menu
         puts ""
         puts "******* Read latest News about Sports you like *******".colorize(:green)

         PostgameStories::Scraper.scrape_menu(BASE_PATH + "/tag/nfl")
         num = PostgameStories::Sports.all.size

         input = nil
          while input != "exit"

            PostgameStories::Sports.all.uniq.each.with_index(1) do |sport, index|
              puts "#{index}. #{sport.name}"
            end

            puts "Enter number [1-#{num}] OR  exit".colorize(:light_blue)
            input = gets.strip
            if input.to_i.between?(1,num)
                name = "NFL"
                PostgameStories::Sports.all.each.with_index(1) do |sport, index|
                  if input.to_i == index
                    name = sport.name
                  end
                end
                display_sports_stories(name)
            elsif input == "exit"
              goodbye
            else
              puts "Invalid entry. Enter number between[1-#{num}]  OR exit".colorize(:light_blue)
            end
          end
          puts ""
     end

     def display_sports_stories(name)
       # if stories about this sport exist, display them
       # otherwise, scrape and then display them
       sporturl = BASE_PATH + "/tag/" + name.downcase
       stories = PostgameStories::Stories.find_by_sport(sporturl)

       if stories == []
         #PostgameStories::Scraper.scrape_stories_details(BASE_PATH + "/tag/" + name.downcase)
         PostgameStories::Scraper.scrape_menu(BASE_PATH + "/tag/" + name.downcase)
         stories = PostgameStories::Stories.find_by_sport(sporturl)
       end


    #  PostgameStories::Stories.destroy
    #  PostgameStories::Scraper.scrape_stories_details(BASE_PATH + "/tag/" + name.downcase)

       puts "________________________________________________________________________________________________________".colorize(:green)
       puts " LATEST #{name} STORIES ".colorize(:green)
       puts "________________________________________________________________________________________________________".colorize(:green)
     stories.each.with_index(1) do |story, index|
       puts " Title       :".colorize(:green) + " #{story.title}"
       puts " Description :".colorize(:green) + "#{story.description}"
       puts " Link        :".colorize(:green) + " #{story.link}".colorize(:blue)
       puts "*********************************************************************************************************".colorize(:green)
     end
 end

 def goodbye
     puts "Good Bye !! Have a nice day !".colorize(:blue)
 end

end
