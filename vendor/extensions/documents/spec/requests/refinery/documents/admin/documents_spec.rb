# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Documents" do
    describe "Admin" do
      describe "documents" do
        login_refinery_user

        describe "documents list" do
          before do
            FactoryGirl.create(:document, :titre => "UniqueTitleOne")
            FactoryGirl.create(:document, :titre => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.documents_admin_documents_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.documents_admin_documents_path

            click_link "Add New Document"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Titre", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Documents::Document.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Titre can't be blank")
              Refinery::Documents::Document.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:document, :titre => "UniqueTitle") }

            it "should fail" do
              visit refinery.documents_admin_documents_path

              click_link "Add New Document"

              fill_in "Titre", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Documents::Document.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:document, :titre => "A titre") }

          it "should succeed" do
            visit refinery.documents_admin_documents_path

            within ".actions" do
              click_link "Edit this document"
            end

            fill_in "Titre", :with => "A different titre"
            click_button "Save"

            page.should have_content("'A different titre' was successfully updated.")
            page.should have_no_content("A titre")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:document, :titre => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.documents_admin_documents_path

            click_link "Remove this document forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Documents::Document.count.should == 0
          end
        end

      end
    end
  end
end
