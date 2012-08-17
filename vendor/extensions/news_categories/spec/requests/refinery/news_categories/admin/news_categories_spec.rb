# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "NewsCategories" do
    describe "Admin" do
      describe "news_categories" do
        login_refinery_user

        describe "news_categories list" do
          before(:each) do
            FactoryGirl.create(:news_category, :name => "UniqueTitleOne")
            FactoryGirl.create(:news_category, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.news_categories_admin_news_categories_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.news_categories_admin_news_categories_path

            click_link "Add New News Category"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::NewsCategories::NewsCategory.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::NewsCategories::NewsCategory.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:news_category, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.news_categories_admin_news_categories_path

              click_link "Add New News Category"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::NewsCategories::NewsCategory.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:news_category, :name => "A name") }

          it "should succeed" do
            visit refinery.news_categories_admin_news_categories_path

            within ".actions" do
              click_link "Edit this news category"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:news_category, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.news_categories_admin_news_categories_path

            click_link "Remove this news category forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::NewsCategories::NewsCategory.count.should == 0
          end
        end

      end
    end
  end
end
