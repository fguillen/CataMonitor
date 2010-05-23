# include PostRank
module SEO
  class PostRank
    def self.request( url )
      conn = ::PostRank::Connection.instance
      conn.appkey = "catamonitor.com"
      ::PostRank::PostRank.calculate([url]).first.postrank
    end
  end
end

# curl "http://api.postrank.com/v1/postrank?appkey=catamonitor.com&format=json" -d "url[]=http://www.igvita.com/2008/06/19/splunk-your-distributed-log-in-ec2/&url[]=http://www.igvita.com/2008/02/11/nginx-and-memcached-a-400-boost/"
