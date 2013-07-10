class User < ActiveRecord::Base
  has_many :tweets
  def tweet(status)
    tweet = tweets.create!(:content => status)
    TweetWorker.perform_async(tweet.id)
end
