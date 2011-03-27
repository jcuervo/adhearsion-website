class PageController < ApplicationController

  def index
    @title = "Open-Source Telephony Development Framework"
    @blog_posts = Hash.from_xml(open("http://pipes.yahoo.com/pipes/pipe.run?_id=7d727342ec97cb855c218e5daba3843c&_render=rss").read)["rss"]["channel"]["item"].to_a.map do |feed_item|
      pub_date = DateTime.parse(feed_item["pubDate"]) rescue Time.now
      { :title => feed_item["title"], :date => pub_date, :url => feed_item["link"] }
    end
  end

  def getting_started
    @title = "Getting Started"
  end

  def testing
  end

  def architecture
    @title = "Architecture Overview"
  end

  def business_case
    @title = "The Business Case"
  end

  def consulting
    @title = "Consulting"
  end

  def contact
    @title = "Contact Us"
  end

  def contributing
    @title = "Contributing"
  end

  def download
    @title = "Download Adhearsion"
  end

  def examples
    @title = "Examples"
  end

  def faq
    @title = "Frequently Asked Questions"
  end

  def irc
    @title = "IRC Chatroom"
  end

  def screencasts
    @title = "Screencasts"
  end

end
