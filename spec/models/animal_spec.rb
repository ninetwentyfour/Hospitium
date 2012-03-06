require 'spec_helper'

describe Animal do
  before(:each) do
    @attr = { 

    }
  end
  
  it{should belong_to(:organization)}
  it{should belong_to(:species)}
  it{should belong_to(:shelter)}
  it{should belong_to(:animal_color)}
  it{should belong_to(:animal_sex)}
  it{should belong_to(:spay_neuter)}
  it{should belong_to(:biter)}
  it{should belong_to(:status)}
  
  it{should have_many(:animal_weights)}
  it{should have_many(:adopt_animals)}
  it{should have_many(:relinquish_animals)}

  
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:date_of_intake)}
  it{should validate_presence_of(:organization)}
  it{should validate_presence_of(:species)}
  it{should validate_presence_of(:animal_color)}
  it{should validate_presence_of(:biter)}
  it{should validate_presence_of(:spay_neuter)}
  it{should validate_presence_of(:animal_sex)}
  it{should validate_presence_of(:status)}
  
  
  describe "#create_uuid" do
    let(:animal) { Factory(:animal) }
    
    it "generates a uuid on creation" do
      animal.uuid.should_not be_nil
    end
  end
  
  describe "#calculate_animal_age" do
    let(:animal) { Factory(:animal, @attr.merge(:birthday => "2001-10-20 00:50:22")) }
    
    it "format birthday" do
      age = (Time.now.year - 2001).to_s + " years"
      animal.calculate_animal_age.should eql(age)
    end
  end
  
  describe "#formatted_deceased_date" do
    let(:animal) { Factory(:animal, @attr.merge(:deceased => "2001-10-20 00:50:22")) }
    
    it "format birthday" do
      age = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      animal.formatted_deceased_date.should eql(age)
    end
  end
end