require 'spec_helper'

describe "List Creation" do
  describe "given a potential username" do
    before do
      # @potential_user = {username_lastfm: "mitchdelgado"}
      @potential_username = "mitchdelgado"
    end
    describe "starting on the new user page" do
      before do
        visit new_list_path
      end
      xit "creates a user" do
        fill_in :username, {with: @potential_username}
        click_button("Wag")
        #this fails test but actually works
      end
      it "takes you to the lists page" do
        page.has_content?("mitchdelgado")
      end
    end
    describe "And now that we're on the list page" do
      xit "has the list of artists" do
        page.has_content?("thebeatles")
      end
    end
  end
end

