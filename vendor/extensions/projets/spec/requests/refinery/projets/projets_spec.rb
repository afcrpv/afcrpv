require "spec_helper"

module Refinery
  module Projets
    describe "projets" do
      before(:each) do
        Factory(:refinery_user)

        # load in seeds we use in migration
        Refinery::Projets::Engine.load_seed
      end

      context "when valid data" do
        it "is successful" do
          visit refinery.projets_new_projet_path

          fill_in "Name", :with => "Ugis Ozols"
          fill_in "Email", :with => "ugis.ozols@refinerycms.com"
          fill_in "Message", :with => "Hey, I'm testing!"
          click_button "Send message"

          page.current_path.should == refinery.thank_you_projets_projets_path
          page.should have_content("Thank You")

          within "#body_content" do
            page.should have_content("We've received your projet and will get back to you with a response shortly.")
            page.should have_content("Return to the home page")
            page.should have_selector("a[href='/']")
          end

          Refinery::Projets::Projet.count.should == 1
        end
      end

      context "when invalid data" do
        it "is not successful" do
          visit refinery.projets_new_projet_path

          click_button "Send message"

          page.current_path.should == refinery.projets_new_projet_path
          page.should have_content("There were problems with the following fields")
          page.should have_content("Name can't be blank")
          page.should have_content("Email is invalid")
          page.should have_content("Message can't be blank")
          page.should have_no_content("Phone can't be blank")

          Refinery::Projets::Projet.count.should == 0
        end
      end
    end
  end
end
