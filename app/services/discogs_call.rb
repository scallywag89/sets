# require 'dotenv/load'

class DiscogsCall
  # Add an action to initiate the process.
  def authenticate
    discogs     = Discogs::Wrapper.new("Sets")
    request_data = @discogs.get_request_token(ENV["DISCOGS_API_KEY"], ENV["DISCOGS_API_SECRET"], "http://127.0.0.1:3000/callback")

    session[:request_token] = request_data[:request_token]

    redirect_to request_data[:authorize_url]
  end

  # And an action that Discogs will redirect back to.
  def callback
    # puts "----------------------------------------------------"
    # puts ENV["DISCOGS_USER_TOKEN"]
    # puts "----------------------------------------------------"
    discogs      = Discogs::Wrapper.new("Sets", user_token: ENV["DISCOGS_USER_TOKEN"])
    # artist = discogs.get_artist("329937")
    # search = discogs.search("Necrovore", :per_page => 10, :type => :artist)
    # puts "----------------------------------------------------"
    # puts search.results.first.type
    # puts "----------------------------------------------------"
    # request_token = session[:request_token]
    # verifier      = params[:oauth_verifier]
    # access_token  = @discogs.authenticate(request_token, verifier)

    # session[:request_token] = nil
    # session[:access_token]  = access_token

    # discogs.access_token = access_token

    # You can now perform authenticated requests.
  end
end
