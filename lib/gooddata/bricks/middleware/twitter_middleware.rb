# require 'twitter'

require File.join(File.dirname(__FILE__), "base_middleware")

module GoodData::Bricks
  
  class TwitterMiddleware < GoodData::Bricks::Middleware

    def call(params)
    
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = params[:twitter_consumer_key]
        config.consumer_secret     = params[:twitter_consumer_secret]
        config.access_token        = params[:twitter_access_token]
        config.access_token_secret = params[:twitter_access_token_secret]
      end

      returning(@app.call(params)) do |result|
        client.update(result)
      end
    end

  end
end