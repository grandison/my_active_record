require 'spec_helper'

describe MyActiveRecord::Base do
  let(:user) { User.find(1) }
  let(:user_without_car) { User.find(2) }

  context "associations" do
    context "#has_one" do
      it "loads association from db" do
        user.car.name.should == "Tata Motors Aria"
      end

      it "is empty by default" do
        user_without_car.car.should be_blank
      end
    end

    context "#belongs_to" do
      it "loads association from db" do
        Car.find(1).user.name.should == "Pedro Rodriguez Ledesma"
      end
    end

    context "#has_many" do
      it "loads association from db" do
        Car.find(1).details.map(&:name).should == ["Windscreen", "Brakes"]
      end
    end
  end
end