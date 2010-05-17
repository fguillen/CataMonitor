module CataMonitor
  class QueriesProcessor
    def self.process
      Query.all.each do |query|
        # "http://socialmention.com/search?q=iphone+apps&f=json&t=microblogs"
      
        params = {:q => query.query, :f => 'json', :t => 'all'}
        result = CataMonitor::QueriesProcessor.http_get( 'api2.socialmention.com', '/search', params ).inspect
        # puts result
        # File.open( "#{RAILS_ROOT}/test/fixtures/social_mention_query_#{query.query.parameterize}.json", 'w') { |f| f.write result }
        # 
        # res = Net::HTTP.get_response( url )
        # mad_cameras_html = res.body
      
      end
    end
    
    def self.digest_json( query, json )
      result = JSON.parse( json )
      puts "XXX: count: #{result['count']}"
      puts "XXX: title: #{result['title']}"
      
      result['items'].each do |item|
        Mention.create!(
          :query_id => query.id,
          :description => item['description'],
          :domain => item['domain'],
          :embed => item['embed'],
          :favicon => item['favicon'],
          :hash_id => item['id'],
          :image => item['image'],
          :language => item['language'],
          :link => item['link'],
          :source => item['source'],
          :timestamp => item['timestamp'],
          :title => item['title'],
          :type => item['type'],
          :user => item['user'],
          :user_id => item['user_id'],
          :user_image => item['user_image'],
          :user_link => item['user_link']
        )
      end
    end
    
    def self.http_get( domain, path, params )
      if params.nil?
        path = path
      else
        path = "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&'))
      end
      
      puts "XXX: domain: #{domain}"
      puts "XXX: path: #{path}"
      
      # puts "XXX: path: #{path}"
      return Net::HTTP.get(domain, path)
    end


    
  end
end