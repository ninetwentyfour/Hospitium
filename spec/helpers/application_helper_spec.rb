require 'spec_helper'

describe ApplicationHelper do
  before :each do
    @link = "https://hospitium.co"
  end
  
  describe '#calculate_animal_age' do
    it 'should return an age string' do
      @birthday = 1.days.ago
      helper.calculate_animal_age(@birthday).should == "1 days"
    end
  end

  describe '#canonical_link_tag' do
    it 'should return a canonical_link_tag' do
      @canonical_url = "/test"
      helper.canonical_link_tag.should == "<link href=\"https://hospitium.co/test\" rel=\"canonical\" />"
    end
  end

  # describe '#current_class?' do
  #   it 'should return active for current class' do
  #     # current_class?('admin/adoption_contacts', controller.action_name)
  #     helper.stub!("current_page?").and_return(true)
  #     helper.current_class?('admin/adoption_contacts', 'index').should == "active"
  #   end
  # end

  describe '#markdown' do
    it 'should return html from text' do
      @text= "### Test"
      helper.markdown(@text).should == "<h3>Test</h3>\n"
    end

    it 'should remove script tags' do
      @text= "<script>alert('test');</script>"
      helper.markdown(@text).should == ""
    end
  end

  describe '#is_table_view' do
    it 'should return a table view true if params table_view' do
      params = {:table_view => 'true'}
      helper.is_table_view(params).should == {:table_view => 'true'}
    end
  end

  describe '#table_view_button' do
    it 'should return a table view true unless params table_view' do
      params = {}
      helper.table_view_button(params).should == {:table_view => 'true'}
    end
  end
end