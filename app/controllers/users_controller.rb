class UsersController < ApplicationController

  def index
  end

  def new
    user = User.find_by_fb_nickname("dealville")
    data = user.get_fb

    artist_list = {}
    # binding.pry
    data.each do |artist_name|
      url_encoded = URI.encode("http://developer.echonest.com/api/v4/artist/twitter?api_key=WUYSVVEOELXPZXCN8&name=#{artist_name}")
      data_echonest = HTTParty.get(url_encoded)
        if ((data_echonest["response"]) && (data_echonest["response"]["artist"]) && (data_echonest["response"]["artist"]["twitter"]))
          twitter_name = data_echonest["response"]["artist"]["twitter"]
          else
            twitter_name = ""
        end
      artist_list[artist_name.to_sym] = [twitter_name]
    end
    # binding.pry
    @fb_list = artist_list


  end

  def show
    @user = User.find(params[:id])

    ### WET:
    # @list = Entry.where(:user_id => params[:id]).map{|e| e.artist.twitter_handle}

    ### DRY:
    @list = @user.entries.map{|e| e.artist.twitter_handle}
    
    @listhash = Hash.new

    ### DRY, works in Pry:
    # Entry.where(:user_id => 9).each do |e|
    #   @listhash[e.artist.name] = e.artist.twitter_handle
    # end

    ### WET:
    Entry.where(:user_id => params[:id]).each do |e|
      @listhash[e.artist.name] = e.artist.twitter_handle
    end
  end



  def create
    unless User.where(username_lastfm: params[:username]).first
      @user = User.create(username_lastfm: params[:username]) 
      @user.get_list
    end
    redirect_to user_path(User.find_by_username_lastfm(params[:username]).id)
  end

  def last_fm
    username = params[:username]
    data = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{username}&api_key=fb7ce62e972081cc10c6b22701a9e9b7&format=json")

    artist_list = {}
    # binding.pry
    data["topartists"]["artist"][0..9].each do |object|
      artist_name = object["name"]
      url_encoded = URI.encode("http://developer.echonest.com/api/v4/artist/twitter?api_key=WUYSVVEOELXPZXCN8&name=#{artist_name}")
      data_echonest = HTTParty.get(url_encoded)
        if ((data_echonest["response"]) && (data_echonest["response"]["artist"]) && (data_echonest["response"]["artist"]["twitter"]))
          twitter_name = data_echonest["response"]["artist"]["twitter"]
          else
            twitter_name = ""
        end
        playcount = object["playcount"].to_i
      artist_list[artist_name.to_sym] = [twitter_name, playcount]
    end
    # binding.pry
    @artist_list = artist_list

    ###facebook here
    user = User.find_by_fb_nickname("dealville")
    data = user.get_fb

    artist_list = {}
    # binding.pry
    data[0..9].each do |artist_name|
      url_encoded = URI.encode("http://developer.echonest.com/api/v4/artist/twitter?api_key=WUYSVVEOELXPZXCN8&name=#{artist_name}")
      data_echonest = HTTParty.get(url_encoded)
        if ((data_echonest["response"]) && (data_echonest["response"]["artist"]) && (data_echonest["response"]["artist"]["twitter"]))
          twitter_name = data_echonest["response"]["artist"]["twitter"]
          else
            twitter_name = ""
        end
      artist_list[artist_name.to_sym] = [twitter_name]
    end
    # binding.pry
    @fb_list = artist_list


  end

end
