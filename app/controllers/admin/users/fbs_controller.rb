class Admin::Users::FbShareController < ApplicationController
 
 
  def auth
 
     cookies["title"] = { :value => "#{params[:title]}", :expires => 1.minute.from_now }
     cookies["url"] = { :value => "#{params[:url]}", :expires => 1.minute.from_now }
     cookies["desc"] = { :value => "#{params[:desc]}", :expires => 1.minute.from_now }

  @client = client
 
    redirect_to @client.authorization_uri(
      :scope => [ :offline_access , :publish_stream]
    )
 
  end
 
 
  def callback
 
    @client = client
    @client.authorization_code = params[:code]
 
    access_token = @client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
 
    me = FbGraph::User.me(access_token)
 
    title = cookies["title"]
    url = cookies["url"]
    desc  = cookies["desc"]
 
    me.feed!(
 
        :message =>  title ,
        :picture => / Your Image path / ,
        :link => url,
        :name => title,
        :description => desc
    )
 
    redirect_to root_path ( You Application Action path After sharing the content to FB)
 
  end
 
 
  private
 
 
  def client
 
    key = "351579198346683"
    secret = "54f60cc0b0d1dc275c4651c6268e5ef4"
    fb_auth = FbGraph::Auth.new(key, secret)
    client = fb_auth.client
    client.redirect_uri = "http://#{request.host_with_port}/fb_share/callback"
 
    client
 
  end
 
end