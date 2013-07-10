class User < ActiveRecord::Base
  has_many :tweets
  def tweet(status)
    tweet = tweets.create!(:content => status)
    puts "HELLO!"
    TweetWorker.perform_async(tweet.id)
    puts "BYE!"
  end
end