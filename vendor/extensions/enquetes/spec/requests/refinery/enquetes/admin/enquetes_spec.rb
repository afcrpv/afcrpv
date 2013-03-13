# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Enquetes" do
    describe "Admin" do
      describe "enquetes" do
        login_refinery_user

        describe "enquetes list" do
          before do
            FactoryGirl.create(:enquete, :code_bnpv => "UniqueTitleOne")
            FactoryGirl.create(:enquete, :code_bnpv => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.enquetes_admin_enquetes_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.enquetes_admin_enquetes_path

            click_link "Add New Enquete"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Code Bnpv", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Enquetes::Enquete.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Code Bnpv can't be blank")
              Refinery::Enquetes::Enquete.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:enquete, :code_bnpv => "UniqueTitle") }

            it "should fail" do
              visit refinery.enquetes_admin_enquetes_path

              click_link "Add New Enquete"

              fill_in "Code Bnpv", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Enquetes::Enquete.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:enquete, :code_bnpv => "A code_bnpv") }

          it "should succeed" do
            visit refinery.enquetes_admin_enquetes_path

            within ".actions" do
              click_link "Edit this enquete"
            end

            fill_in "Code Bnpv", :with => "A different code_bnpv"
            click_button "Save"

            page.should have_content("'A different code_bnpv' was successfully updated.")
            page.should have_no_content("A code_bnpv")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:enquete, :code_bnpv => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.enquetes_admin_enquetes_path

            click_link "Remove this enquete forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Enquetes::Enquete.count.should == 0
          end
        end

      end
    end
  end
end
