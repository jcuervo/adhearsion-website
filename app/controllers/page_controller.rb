class PageController < ApplicationController

  def index
    @blog_posts = Hash.from_xml(open("http://pipes.yahoo.com/pipes/pipe.run?_id=7d727342ec97cb855c218e5daba3843c&_render=rss").read)["rss"]["channel"]["item"].to_a.map do |feed_item|
      pub_date = DateTime.parse(feed_item["pubDate"]) rescue Time.now
      { :title => feed_item["title"], :date => pub_date, :url => feed_item["link"] }
    end
  end

  def contact
  end

  def contributing
  end

  def download
  end

  def examples
  end

  def faq
  end

  def irc
  end

  def screencasts
  end

end
