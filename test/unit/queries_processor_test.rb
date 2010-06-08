require 'test_helper'

class QueriesProcessorTest < ActiveSupport::TestCase

  
  def test_digest_json_iphone
    SEO::GooglePR.stubs( :request ).returns( 2 )
    SEO::PostRank.stubs( :request ).returns( 1 )
    
    
    query = Factory(:query)
    json = File.read( "#{RAILS_ROOT}/test/fixtures/social_mention_iphone_blogs_microblogs.json" )
    assert_difference "Mention.count", 672 do
      CataMonitor::QueriesProcessor.digest_json( query, json )
    end
    
    mention = Mention.find_by_m_id( '17366750231643446468' )
    assert_equal( '', mention.m_description )
    assert_equal( 'twitter.com', mention.m_domain )
    assert_equal( nil, mention.m_embed )
    assert_equal( 'http://twitter.com/favicon.ico', mention.m_favicon )
    assert_equal( '17366750231643446468', mention.m_id )
    assert_equal( nil, mention.m_image )
    assert_equal( 'en', mention.m_language )
    assert_equal( 'http://twitter.com/ajaimk/statuses/14155149969', mention.m_link )
    assert_equal( 'twitter', mention.m_source )
    assert_equal( '201005171120', mention.m_timestamp.strftime( "%Y%m%d%H%M" ) )
    assert_equal( '@mattstech Predict that the Kin is to the iPhone as the Zune was to the iPod ;-)', mention.m_title )
    assert_equal( 'microblogs', mention.m_type )
    assert_equal( 'ajaimk', mention.m_user )
    assert_equal( '2354498', mention.m_user_id )
    assert_equal( 'http://a3.twimg.com/profile_images/869254845/twitter_normal.png', mention.m_user_image )
    assert_equal( 'http://twitter.com/ajaimk', mention.m_user_link )
    assert_equal( 2.0, mention.pagerank )
    assert_equal( 1.0, mention.postrank )

      
    mention = Mention.find_by_m_id( '6084506213657997802' )
    assert_equal( '', mention.m_description )
    assert_equal( 'army.twit.tv', mention.m_domain )
    assert_equal( nil, mention.m_embed )
    assert_equal( 'http://army.twit.tv/favicon.ico', mention.m_favicon )
    assert_equal( '6084506213657997802', mention.m_id )
    assert_equal( nil, mention.m_image )
    assert_equal( 'en', mention.m_language )
    assert_equal( 'http://army.twit.tv/notice/423655', mention.m_link )
    assert_equal( 'twitarmy', mention.m_source )
    assert_equal( nil, mention.m_timestamp )
    assert_equal( '!iphone New TomTom Update Now Allows it To Work With the iPodTouch, using the TomTom Car Kit.', mention.m_title )
    assert_equal( 'microblogs', mention.m_type )
    assert_equal( 'terryh', mention.m_user )
    assert_equal( '412', mention.m_user_id )
    assert_equal( 'http://army.twit.tv/avatar/412-48-20100405104921.png', mention.m_user_image )
    assert_equal( 'http://army.twit.tv/terryh', mention.m_user_link )
    assert_equal( 2.0, mention.pagerank )
    assert_equal( 1.0, mention.postrank )
  end

  def test_process_all
    SEO::GooglePR.stubs( :request ).returns( 2 )
    SEO::PostRank.stubs( :request ).returns( 1 )
    
    query = Factory(:query)
    json = File.read( "#{RAILS_ROOT}/test/fixtures/social_mention_jquery_all.json" )
    
    CataMonitor::QueriesProcessor.expects(:http_get).returns( json ).times(3)

    assert_difference "Mention.count", 878 do
      CataMonitor::QueriesProcessor.process_all
    end
    
    mention = Mention.find_by_m_id( '5375012168050394442' )
    assert_equal( '', mention.m_description )
    assert_equal( 'stumbleupon.com', mention.m_domain )
    assert_equal( nil, mention.m_embed )
    assert_equal( 'http://stumbleupon.com/favicon.ico', mention.m_favicon )
    assert_equal( '5375012168050394442', mention.m_id )
    assert_equal( nil, mention.m_image )
    assert_equal( 'en', mention.m_language )
    assert_equal( 'http://twitter.com/galaxark/statuses/14214883381', mention.m_link )
    assert_equal( 'stumbleupon', mention.m_source )
    assert_equal( '201005180807', mention.m_timestamp.strftime( "%Y%m%d%H%M" ) )
    assert_equal( 'JQuery Scrolling Effect for Designers http://bit.ly/91CHRU', mention.m_title )
    assert_equal( 'bookmarks', mention.m_type )
    assert_equal( 'galaxark', mention.m_user )
    assert_equal( nil, mention.m_user_id )
    assert_equal( nil, mention.m_user_image )
    assert_equal( 'http://friendfeed.com/galaxark', mention.m_user_link )
  end
  
  def test_process_query
    SEO::GooglePR.stubs( :request ).returns( 2 )
    SEO::PostRank.stubs( :request ).returns( 1 )
    
    query = Factory(:query)
    json = File.read( "#{RAILS_ROOT}/test/fixtures/social_mention_jquery_all.json" )
    
    CataMonitor::QueriesProcessor.expects(:http_get).returns( json ).times(3)

    assert_difference "Mention.count", 878 do
      CataMonitor::QueriesProcessor.process_query( query )
    end
    
    mention = Mention.find_by_m_id( '5375012168050394442' )
    assert_equal( '', mention.m_description )
    assert_equal( 'stumbleupon.com', mention.m_domain )
    assert_equal( nil, mention.m_embed )
    assert_equal( 'http://stumbleupon.com/favicon.ico', mention.m_favicon )
    assert_equal( '5375012168050394442', mention.m_id )
    assert_equal( nil, mention.m_image )
    assert_equal( 'en', mention.m_language )
    assert_equal( 'http://twitter.com/galaxark/statuses/14214883381', mention.m_link )
    assert_equal( 'stumbleupon', mention.m_source )
    assert_equal( '201005180807', mention.m_timestamp.strftime( "%Y%m%d%H%M" ) )
    assert_equal( 'JQuery Scrolling Effect for Designers http://bit.ly/91CHRU', mention.m_title )
    assert_equal( 'bookmarks', mention.m_type )
    assert_equal( 'galaxark', mention.m_user )
    assert_equal( nil, mention.m_user_id )
    assert_equal( nil, mention.m_user_image )
    assert_equal( 'http://friendfeed.com/galaxark', mention.m_user_link )
  end
  
  def test_process_query_not_register_already_registered_mentions
    SEO::GooglePR.stubs( :request ).returns( 2 )
    SEO::PostRank.stubs( :request ).returns( 1 )
    
    query = Factory(:query)
    json = File.read( "#{RAILS_ROOT}/test/fixtures/only_one.json" )
    
    CataMonitor::QueriesProcessor.expects(:http_get).returns( json ).times(6)

    assert_difference "Mention.count", 1 do
      CataMonitor::QueriesProcessor.process_query( query )
    end
    
    assert_difference "Mention.count", 0 do
      CataMonitor::QueriesProcessor.process_query( query )
    end
  end

  
  
end
