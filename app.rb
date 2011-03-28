require 'open-uri'

Sinatra.register SinatraMore::MarkupPlugin

get '/' do
  @blog_posts = Hash.from_xml(open("http://pipes.yahoo.com/pipes/pipe.run?_id=7d727342ec97cb855c218e5daba3843c&_render=rss").read)["rss"]["channel"]["item"].to_a.map do |feed_item|
    pub_date = DateTime.parse(feed_item["pubDate"]) rescue Time.now
    { :title => feed_item["title"], :date => pub_date, :url => feed_item["link"] }
  end
  erb :index
end

[:contact, :contributing, :download, :examples, :faq, :irc, :screencasts].each do |page|
  get "/#{page}" do
    erb page
  end
end

get '/consulting' do
  redirect 'http://mojolingo.com/adhearsion-consulting.php'
end

def title(page_title, show_title = true)
  content_for(:title) { page_title.to_s }
  @show_title = show_title
end

def show_title?
  @show_title
end
