require 'spec_helper'

describe List do

  describe "Given the username" do
    before do
      @username_lastfm = "mitchdelgado"
    end
    describe ".getter_lastfm gets the top artists" do
      before do
        @list = List.getter_lastfm(@username_lastfm)
      end
    end

  end


  xit "gets an array of artists" do
    @lis
  end

  # before do
  #   @username_lastfm = "mitchdelgado"
  #   @test_firstband = "the beatles"
  # end

  # describe "List#getter_lastfm" do


  #   it "Should return an array of artists" do
  #     expect(@artist_names.first).to start_with "thebeatles"
  #   end

  #   xit "assigns @artists" do
  #   end

  #   describe "List#getter_echonest" do
  #     xit "Should return the info for a single artist" do
  #       expect(@artist[1]).to eg("thebeatles")
  #     end
  #   end

  # end
end
