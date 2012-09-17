require 'spec_helper'

module Refinery
  module Emplois
    describe Emploi do
      describe "validations" do
        subject do
          FactoryGirl.create(:emploi,
          :organisation => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:organisation) { should == "Refinery CMS" }
      end
    end
  end
end
