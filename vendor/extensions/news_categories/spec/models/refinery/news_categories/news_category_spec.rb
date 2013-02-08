require 'spec_helper'

module Refinery
  module NewsCategories
    describe NewsCategory do
      describe "validations" do
        subject do
          FactoryGirl.create(:news_category,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
