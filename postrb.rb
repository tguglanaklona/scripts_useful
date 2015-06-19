require 'rest_client'
res = RestClient.post 'http://poster.decaptcher.com', :source=>File.new('im.jpeg')
