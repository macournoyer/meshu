require "activerecord"

class LastFeedEntry
  class Feed < ActiveRecord::Base; end
  
  def call(env)
    feed = Feed.find(:first, :order => "random()")
    body = %Q{<div id="#{feed.id}" class="entry">#{feed.message}</div>}
    
    [
      200,
      {
        'Content-Type' => 'text/html',
        'Content-Length' => body.size.to_s
      },
      body
    ]
  end
end

configuration_options = File.open("config/database.yml") { |file| YAML.load(file) }["production"]
ActiveRecord::Base.establish_connection(configuration_options)

run LastFeedEntry.new