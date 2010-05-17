require 'test_helper'

class QueriesProcessorTest < ActiveSupport::TestCase
  def test_digest_json
    query = Factory(:query)
    json = File.read( "#{RAILS_ROOT}/test/fixtures/social_mention_iphone_blogs_microblogs.json" )
    CataMonitor::QueriesProcessor.digest_json( query, json )
    
    query.reload
    query.mentions.each do |mention|
      puts "XXX: (#{mention.timestamp}): #{mention.title}"
    end
  end
end
