# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include AuthenticatedSystem

  before_filter :check_uri
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5b993ddc06f5bcbbc7832668306e59c1'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  def check_uri
    if /^www/.match(request.host)
      redirect_to request.protocol + request.host_with_port[4..-1] + request.request_uri 
    end
  end
  
  def load_blog_posts_from_aggregator
    feed_url = "http://pipes.yahoo.com/pipes/pipe.run?_id=7d727342ec97cb855c218e5daba3843c&_render=rss"
    feed_content = open(feed_url).read

    parsed_feed = Hash.from_xml feed_content
    feed_items = parsed_feed["rss"]["channel"]["item"]

    normalized = feed_items.to_a.map do |feed_item|
      title    = feed_item["title"]
      pub_date = DateTime.parse(feed_item["pubDate"]) rescue Time.now
      url      = feed_item["link"]
      p feed_item["guid"]
      {:title => title, :date => pub_date, :url => url}
    end
  end
  
end
