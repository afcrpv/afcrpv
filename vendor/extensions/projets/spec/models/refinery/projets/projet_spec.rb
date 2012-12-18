require 'spec_helper'

module Refinery
  module Projets
    describe Projet do
      describe "validations" do
        subject do
          Factory.build(:projet,
                        :name => "Ugis Ozols",
                        :email => "ugis.ozols@refinerycms.com",
                        :message => "Hey, I'm testing!")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Ugis Ozols" }
        its(:email) { should == "ugis.ozols@refinerycms.com" }
        its(:message) { should == "Hey, I'm testing!" }
      end

      describe "default scope" do
        it "orders by created_at in desc" do
          projet1 = Factory(:projet, :created_at => 1.hour.ago)
          projet2 = Factory(:projet, :created_at => 2.hours.ago)
          projets = Refinery::Projets::Projet.all
          projets.first.should == projet1
          projets.second.should == projet2
        end
      end

      describe ".latest" do
        it "returns latest 7 non-spam projets by default" do
          8.times { Factory(:projet) }
          Refinery::Projets::Projet.last.toggle!(:spam)
          Refinery::Projets::Projet.latest.length.should == 7
        end

        it "returns latest 7 projets including spam ones" do
          7.times { Factory(:projet) }
          Refinery::Projets::Projet.all[0..2].each { |projet| projet.toggle!(:spam) }
          Refinery::Projets::Projet.latest(7, true).length.should == 7
        end

        it "returns latest n projets" do
          4.times { Factory(:projet) }
          Refinery::Projets::Projet.latest(3).length.should == 3
        end
      end
    end
  end
end
