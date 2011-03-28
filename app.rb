require 'open-uri'

use Rack::Cache,
  :verbose     => true,
  :metastore   => 'file:tmp/cache/rack/meta',
  :entitystore => 'file:tmp/cache/rack/body'

Sinatra.register SinatraMore::MarkupPlugin

before do
  cache_control :public, :must_revalidate, :max_age => 1.hour
end

get '/' do
  @blog_posts = Hash.from_xml(open("http://pipes.yahoo.com/pipes/pipe.run?_id=7d727342ec97cb855c218e5daba3843c&_render=rss").read)["rss"]["channel"]["item"].to_a.map do |feed_item|
    pub_date = DateTime.parse(feed_item["pubDate"]) rescue Time.now
    { :title => feed_item["title"], :date => pub_date, :url => feed_item["link"] }
  end
  last_modified @blog_posts.first[:date]
  etag @blog_posts.first.hash
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
