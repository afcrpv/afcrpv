require 'spec_helper'

module Refinery
  module Enquetes
    describe Enquete do
      describe "validations" do
        subject do
          FactoryGirl.create(:enquete,
          :code_bnpv => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:code_bnpv) { should == "Refinery CMS" }
      end
    end
  end
end
