class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username_lastfm, :twitter_handle

  has_many :entries
  # has_many :entries, through: :lists
  has_many :artists, through: :entries




  ###### LAST.FM GETTER ###########


  # def api_lastfm(username)
  #   data_lastfm = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{username}&api_key=fb7ce62e972081cc10c6b22701a9e9b7&format=json")
  #   return data_lastfm
  # end


  # def get_list
  #   id = self.id
  #   username = self.username_lastfm
  #   data = self.api_lastfm(username)
  #   data["topartists"]["artist"].first(10).each do |object|

  #     ###### Creates artists in DB #######
  #     artist = Artist.find_or_create_by_name(object["name"]) 

  #     ###### Creates entries in DB #######
  #     entry = Entry.new
  #     entry.artist = artist
  #     entry.user = self
  #     entry.lastfm_top_all = object["@attr"]["rank"].to_i
  #     entry.save!
  #   end

  #   data["topartists"]["artist"].each do |object|
  #     artistname = object["name"]
  #     url_encoded = URI.encode("http://developer.echonest.com/api/v4/artist/twitter?api_key=WUYSVVEOELXPZXCN8&name=#{artistname}")
  #     data_echonest = HTTParty.get(url_encoded)
  #     if (artist = Artist.find_by_name(artistname)) &&
  #       (data_echonest["response"]) &&
  #       (data_echonest["response"]["artist"]) &&
  #       (twitter_name = data_echonest["response"]["artist"]["twitter"])
  #       artist.twitter_handle = twitter_name
  #       artist.save!
  #     end
  #   end
  # end



###### DEVISE FOR FACEBOOK ###########

  devise :omniauthable, :omniauth_providers => [:facebook]


  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name  # assuming the user model has a name
      user.fb_token = auth.credentials.token
      user.fb_nickname = auth.info.nickname
      user.save!
    end
  end

  # Login user in if they already have a session
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

##### FACEBOOK #######################


  def get_fb
    nickname = self.fb_nickname
    # token = self.fb_token
    token = "CAACEdEose0cBADXYaZCeiMbxgPlbqm4aM3TEdiZAX9eXW6Td5ZC1KrAX8BFd7pRwaX82yJuA8ZBtWPo3EdZANKuS6xOMXF6dZBtOZBhjhAwBeIp87iz38lhoePsAZBEii1S33TaJm4aIDe82MfpVxFsSKH7ZBFGqRpCb4PYQOGEAZCjM8h8Yz3rLHhEvNHZCQgfqzUZD"

    url_encoded = URI.encode("https://graph.facebook.com/#{nickname}/music?access_token=#{token}")
    data_fb = HTTParty.get(url_encoded)
    data_fb = JSON(data_fb)



#####------- TEMPORARY SEED DATA -------


    data_fb = {
"data"=>
  [{"category"=>"Musician/band",
    "name"=>"Motive",
    "created_time"=>"2013-10-21T21:32:31+0000",
    "id"=>"152381248115323"},
   {"category"=>"Music",
    "name"=>"Danger Mouse",
    "created_time"=>"2013-08-07T09:03:00+0000",
    "id"=>"109611215723429"},
   {"category"=>"Musician/band",
    "name"=>"Young Yeller",
    "created_time"=>"2013-07-10T19:30:47+0000",
    "id"=>"147111642022685"},
   {"category"=>"Musician/band",
    "name"=>"Kay Kay and His Weathered Underground",
    "created_time"=>"2013-05-01T23:34:41+0000",
    "id"=>"113061008725672"},
   {"category"=>"Musician/band",
    "name"=>"Milk Dick",
    "created_time"=>"2013-04-22T13:09:59+0000",
    "id"=>"217769214996027"},
   {"category"=>"Musician/band",
    "name"=>"Mos Def Official",
    "created_time"=>"2013-03-27T22:48:50+0000",
    "id"=>"45907623491"},
   {"category"=>"Musician/band",
    "name"=>"Röyksopp",
    "created_time"=>"2013-03-27T22:47:21+0000",
    "id"=>"11052436635"},
   {"category"=>"Musician/band",
    "name"=>"AIR",
    "created_time"=>"2013-03-27T22:47:17+0000",
    "id"=>"7530846195"},
   {"category"=>"Musician/band",
    "name"=>"Hot Chip",
    "created_time"=>"2013-03-27T22:47:02+0000",
    "id"=>"9270736186"},
   {"category"=>"Musician/band",
    "name"=>"Missy Elliott",
    "created_time"=>"2013-03-27T22:46:49+0000",
    "id"=>"11154087554"},
   {"category"=>"Musician/band",
    "name"=>"Das Racist",
    "created_time"=>"2013-03-27T22:46:28+0000",
    "id"=>"182793228220"},
   {"category"=>"Musician/band",
    "name"=>"Swans",
    "created_time"=>"2013-03-27T22:46:22+0000",
    "id"=>"103130976393270"},
   {"category"=>"Musician/band",
    "name"=>"MGMT",
    "created_time"=>"2013-03-27T22:46:17+0000",
    "id"=>"35850344767"},
   {"category"=>"Musician/band",
    "name"=>"Justice",
    "created_time"=>"2013-03-27T22:46:13+0000",
    "id"=>"39082832518"},
   {"category"=>"Musician/band",
    "name"=>"St. Vincent",
    "created_time"=>"2013-03-27T22:46:07+0000",
    "id"=>"64294390660"},
   {"category"=>"Musician/band",
    "name"=>"Gorillaz",
    "created_time"=>"2013-03-27T22:45:41+0000",
    "id"=>"6002137995"},
   {"category"=>"Musician/band",
    "name"=>"Danger Mouse Official",
    "created_time"=>"2011-12-22T08:36:00+0000",
    "id"=>"200037953399703"},
   {"category"=>"Music",
    "name"=>"epic headnautica",
    "created_time"=>"2011-12-22T08:35:19+0000",
    "id"=>"195389467222690"},
   {"category"=>"Music",
    "name"=>"disgusting funk",
    "created_time"=>"2011-12-22T08:35:19+0000",
    "id"=>"197711986987422"},
   {"category"=>"Music",
    "name"=>"hallucinatory pop",
    "created_time"=>"2011-12-22T08:35:19+0000",
    "id"=>"284594568258110"},
   {"category"=>"Musician/band",
    "name"=>"The Roots",
    "created_time"=>"2010-06-01T02:15:42+0000",
    "id"=>"105504696150918"},
   {"category"=>"Musician/band",
    "name"=>"Zero 7",
    "created_time"=>"2010-06-01T02:15:42+0000",
    "id"=>"113427625337591"}]}

#####------- END TEMPORARY SEED DATA -------



    @artists = data_fb["data"].map do |object|
      object["name"]
    end

  return @artists
  end



end