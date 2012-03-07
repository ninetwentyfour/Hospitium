require 'spec_helper'

describe Animal do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
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
  end

  describe "validations" do
    it{should validate_presence_of(:name)}
    it{should validate_presence_of(:date_of_intake)}
    it{should validate_presence_of(:organization)}
    it{should validate_presence_of(:species)}
    it{should validate_presence_of(:animal_color)}
    it{should validate_presence_of(:biter)}
    it{should validate_presence_of(:spay_neuter)}
    it{should validate_presence_of(:animal_sex)}
    it{should validate_presence_of(:status)}
  end
  
  
  describe "#create_uuid" do
    let(:animal) { Factory(:animal) }
    
    it "generates a uuid on creation" do
      animal.uuid.should_not be_nil
    end
  end
  
  describe "#calculate_animal_age" do
    let(:animal) { Factory(:animal, @attr.merge(:birthday => "2001-10-20 00:50:22")) }
    
    it "should format birthday" do
      age = (Time.now.year - 2001).to_s + " years"
      animal.calculate_animal_age.should eql(age)
    end
    
    it "should return empty string if nil" do
      animal.birthday = nil
      animal.calculate_animal_age.should eql("")
    end
  end
  
  describe "#formatted_deceased_date" do
    let(:animal) { Factory(:animal, @attr.merge(:deceased => "2001-10-20 00:50:22")) }
    
    it "should format deceased date" do
      age = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      animal.formatted_deceased_date.should eql(age)
    end
    
    it "should return empty string if nil" do
      animal.deceased = nil
      animal.formatted_deceased_date.should eql("")
    end
  end
  
  describe "#formatted_intake_date" do
    let(:animal) { Factory(:animal, @attr.merge(:date_of_intake => "2001-10-20 00:50:22")) }
    
    it "should format intake date" do
      age = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      animal.formatted_intake_date.should eql(age)
    end
    
    it "should return empty string if nil" do
      animal.date_of_intake = nil
      animal.formatted_intake_date.should eql("")
    end
  end
  
  describe "#formatted_well_date" do
    let(:animal) { Factory(:animal, @attr.merge(:date_of_well_check => "2001-10-20 00:50:22")) }
    
    it "should format well check date" do
      age = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      animal.formatted_well_date.should eql(age)
    end
    
    it "should return empty string if nil" do
      animal.date_of_well_check = nil
      animal.formatted_well_date.should eql("")
    end
  end
  
  describe "upload image" do
    it {should have_attached_file(:image)}
    it {should validate_attachment_content_type(:image).allowing('image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png').rejecting('text/plain', 'text/xml')}

    it {should have_attached_file(:second_image)}
    it {should validate_attachment_content_type(:second_image).allowing('image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png').rejecting('text/plain', 'text/xml')}

    it {should have_attached_file(:third_image)}
    it {should validate_attachment_content_type(:third_image).allowing('image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png').rejecting('text/plain', 'text/xml')}

    it {should have_attached_file(:fourth_image)}
    it {should validate_attachment_content_type(:fourth_image).allowing('image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png').rejecting('text/plain', 'text/xml')}
  end
  

  
end