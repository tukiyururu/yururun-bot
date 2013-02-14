# -*- coding: utf-8 -*-

require 'twitter'
require 'clockwork'
include Clockwork

STDOUT.sync = true

Twitter.configure do |config|
    config.consumer_key       = ENV['CONSUMER_KEY']
    config.consumer_secret    = ENV['CONSUMER_SECRET']
    config.oauth_token        = ENV['OAUTH_TOKEN']
    config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end
client = Twitter::Client.new

n = 0

handler do |job|
    begin
        n += 1
        client.update( "ツイートテスト\s\##{ n }回" )
        puts "Successfully\stweeted(#{ n })"
    rescue StandardError, Timeout::Error => ex
        puts ex.message
    end
end

every( 180.seconds, 'frequent.job' )
