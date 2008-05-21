require "activerecord"

class LastFeedEntry
  class Feed < ActiveRecord::Base; end
  
  def call(env)
    feed = Feed.find(:first, :order => "random()")
    body = render(feed)
    
    [
      200,
      {
        'Content-Type' => 'text/html',
        'Content-Length' => body.size.to_s
      },
      body
    ]
  end
  
  def render(feed)
    %Q{<div id="#{feed.id}" class="entry">#{feed.message}</div>}
  end
end

configuration_options = YAML::load(File.open("/Users/marc/projects/standoutjobs/trunk/config/database.yml"))["development"]
ActiveRecord::Base.establish_connection(configuration_options)

run LastFeedEntry.new