require 'rest_client'

def post_captchaSniper(filename)
  res = RestClient.post 'http://127.0.0.1:80', :source=>File.new(filename)
  return res
end

def post_captchaSniper_href(href)
  fName = 'temp.gif'
  f = File.new(fName, 'w')
  if !f
    return nil
  end
  f.write(RestClient.get href)
  f.close
  return post_captchaSniper(fName)
end