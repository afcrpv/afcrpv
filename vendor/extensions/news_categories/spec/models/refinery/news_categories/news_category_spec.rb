require 'spec_helper'

module Refinery
  module NewsCategories
    describe NewsCategory do
      describe "validations" do
        subject do
          FactoryGirl.create(:news_category,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
