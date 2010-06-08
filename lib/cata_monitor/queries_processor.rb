module CataMonitor
  class QueriesProcessor
    def self.process_all
      Query.all.each do |query|
        CataMonitor::QueriesProcessor.process_query( query )
      end
    end
    
    def self.process_query( query )
      mentions = []
      ['', 'es', 'en'].each do |lang|
        params = {:q => query.query, :f => 'json', :t => 'all', :lang => lang}
        result = CataMonitor::QueriesProcessor.http_get( 'api2.socialmention.com', '/search', params )
        # File.open( "#{RAILS_ROOT}/test/fixtures/social_mention_query_#{query.query.parameterize}_#{Time.now.strftime("%Y%m%d%H%M%S")}.json", 'w') { |f| f.write result }      
        mentions.concat CataMonitor::QueriesProcessor.digest_json( query, result )        
      end
        
      puts "XXX: mentions created for '#{query.query}': #{mentions.size}"
      
      return mentions
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

        # only add if not already registered
        if( !query.mentions.exists?( :m_id => item['id'] ) )
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
            
          begin
            mention.update_attribute( :pagerank, SEO::GooglePR.request(item['link']) )
          rescue Exception => e
            puts "ERROR calculating PageRank for: '#{item['link']}', e: #{e.message}"
          end
          
          begin
            mention.update_attribute( :postrank, SEO::PostRank.request(item['link']) )
          rescue Exception => e
            puts "ERROR calculating PostRank for: '#{item['link']}', e: #{e.message}"
          end
          
          mentions << mention
        end
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