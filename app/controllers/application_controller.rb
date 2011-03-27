class ApplicationController < ActionController::Base
  protect_from_forgery

  include AuthenticatedSystem

  before_filter :check_uri

  helper :all # include all helpers, all the time

  def check_uri
    redirect_to request.protocol + request.host_with_port[4..-1] + request.request_uri if /^www/.match(request.host)
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
