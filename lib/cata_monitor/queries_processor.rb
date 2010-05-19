module CataMonitor
  class QueriesProcessor
    def self.process
      Query.all.each do |query|
        # "http://socialmention.com/search?q=iphone+apps&f=json&t=microblogs"
      
        params = {:q => query.query, :f => 'json', :t => 'all'}
        result = CataMonitor::QueriesProcessor.http_get( 'api2.socialmention.com', '/search', params )
        # puts result
        File.open( "#{RAILS_ROOT}/test/fixtures/social_mention_query_#{query.query.parameterize}_#{Time.now.strftime("%Y%m%d%H%M%S")}.json", 'w') { |f| f.write result }
        
        mentions = CataMonitor::QueriesProcessor.digest_json( query, result )
        
        puts "XXX: mentions created for '#{query.query}': #{mentions.size}"
      end
    end
    
    def self.digest_json( query, json )
      result = JSON.parse( json )
      mentions = []
      puts "XXX: count: #{result['count']}"
      puts "XXX: title: #{result['title']}"
      
      result['items'].each do |item|
        # puts "XXX: item['id']: #{item['id']}"
        timestamp = nil
        if( item['timestamp'].kind_of?(Numeric) && item['timestamp'] > 3000 )
          timestamp = Time.at(item['timestamp'])
        end
        
        mention =
          Mention.create!(
            :query_id => query.id,
            :m_description => item['description'],
            :m_domain => item['domain'],
            :m_embed => item['embed'],
            :m_favicon => item['favicon'],
            :m_id => item['id'],
            :m_image => item['image'],
            :m_language => item['language'],
            :m_link => item['link'],
            :m_source => item['source'],
            :m_timestamp => timestamp,
            :m_title => item['title'],
            :m_type => item['type'],
            :m_user => item['user'],
            :m_user_id => item['user_id'],
            :m_user_image => item['user_image'],
            :m_user_link => item['user_link'],
            :register_at => Time.now
          )
          
        mentions << mention
      end
      
      return mentions
    end
    
    def self.http_get( domain, path, params )
      if params.nil?
        path = path
      else
        path = "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&'))
      end
      
      puts "XXX: url: http://#{domain}#{path}"
      res = Net::HTTP.start(domain) { |http| http.get( path ) }      
      result = res.body
      
      return result
    end


    
  end
end