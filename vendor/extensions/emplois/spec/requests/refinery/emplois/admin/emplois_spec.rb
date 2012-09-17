# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Emplois" do
    describe "Admin" do
      describe "emplois" do
        login_refinery_user

        describe "emplois list" do
          before(:each) do
            FactoryGirl.create(:emploi, :organisation => "UniqueTitleOne")
            FactoryGirl.create(:emploi, :organisation => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.emplois_admin_emplois_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.emplois_admin_emplois_path

            click_link "Add New Emploi"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Organisation", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Emplois::Emploi.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Organisation can't be blank")
              Refinery::Emplois::Emploi.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:emploi, :organisation => "UniqueTitle") }

            it "should fail" do
              visit refinery.emplois_admin_emplois_path

              click_link "Add New Emploi"

              fill_in "Organisation", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Emplois::Emploi.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:emploi, :organisation => "A organisation") }

          it "should succeed" do
            visit refinery.emplois_admin_emplois_path

            within ".actions" do
              click_link "Edit this emploi"
            end

            fill_in "Organisation", :with => "A different organisation"
            click_button "Save"

            page.should have_content("'A different organisation' was successfully updated.")
            page.should have_no_content("A organisation")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:emploi, :organisation => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.emplois_admin_emplois_path

            click_link "Remove this emploi forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Emplois::Emploi.count.should == 0
          end
        end

      end
    end
  end
end
