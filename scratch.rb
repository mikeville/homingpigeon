 username = params[:username]
    data = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{username}&api_key=fb7ce62e972081cc10c6b22701a9e9b7&format=json")

    artist = {artistname: "", twitter_name: ""}
    array = []
    # binding.pry
    data["topartists"]["artist"].each do |object|
      artist[:artistname] = object["name"]
      url_encoded = URI.encode("http://developer.echonest.com/api/v4/artist/twitter?api_key=WUYSVVEOELXPZXCN8&name=#{artist[:artistname]}")
      data_echonest = HTTParty.get(url_encoded)
      if (artist = Artist.find_by_name(artist[:artistname])) &&
        (data_echonest["response"]) &&
        (data_echonest["response"]["artist"]) &&
        (artist[:twitter_name] = data_echonest["response"]["artist"]["twitter"])
      end
      array << artist