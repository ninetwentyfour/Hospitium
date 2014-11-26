require 'spec_helper'

describe ApplicationHelper do
  describe '#calculate_animal_age' do
    it 'should return an age string' do
      birthday = 1.days.ago
      expect(helper.calculate_animal_age(birthday)).to eq '1 days'
    end
  end

  describe '#canonical_link_tag' do
    it 'should return a canonical_link_tag' do
      @canonical_url = '/test'
      expect(helper.canonical_link_tag).to eq '<link href="https://hospitium.co/test" rel="canonical" />'
    end
  end

  describe '#current_class?' do
    it 'should return "active" for current class if the current_page? is true' do
      expect(helper).to receive(:current_page?).and_return(true)
      expect(helper.current_class?('admin/adoption_contacts', 'index')).to eq 'active'
    end

    it 'should return "" for current class if the current_page? is false' do
      expect(helper).to receive(:current_page?).and_return(false)
      expect(helper.current_class?('admin/adoption_contacts', 'index')).to eq ''
    end
  end

  describe '#markdown' do
    it 'should return html from text' do
      text = '### Test'
      expect(helper.markdown(text)).to eq "<h3>Test</h3>\n"
    end

    it 'should remove script tags' do
      text = '<script>alert("test");</script>'
      expect(helper.markdown(text)).to eq ''
    end
  end

  describe '#is_table_view' do
    it 'should return a table view true if params table_view' do
      params = {:table_view => 'true'}
      expect(helper.is_table_view(params)).to eq({:table_view => 'true'})
    end
  end

  describe '#table_view_button' do
    it 'should return a table view true unless params table_view' do
      params = {}
      expect(helper.table_view_button(params)).to eq({table_view: 'true'})
    end

    it 'add the table_view params to existing params' do
      params = {example: 'test'}
      expect(helper.table_view_button(params)).to eq({example: 'test', table_view: 'true'})
    end

    it 'should return the original params if table_view param is present and set table_view to nil' do
      params = {example: 'test', table_view: 'true'}
      expect(helper.table_view_button(params)).to eq({example:'test', table_view: nil})
    end
  end

  describe '#table_button_text' do
    it 'returns "Card View" when table_view param is present' do
      params = {table_view: 'true'}
      expect(helper.table_button_text(params)).to eq '<i class="fa fa-refresh"></i> Card View'
    end

    it 'returns "Table View" when table_view param is not present' do
      params = {}
      expect(helper.table_button_text(params)).to eq '<i class="fa fa-refresh"></i> Table View'
    end
  end

  describe '#archived_view_button' do
    it 'should return a archived_view true unless params archived_view' do
      params = {}
      expect(helper.archived_view_button(params)).to eq({archived_view: 'true'})
    end

    it 'add the archived_view params to existing params' do
      params = {example: 'test'}
      expect(helper.archived_view_button(params)).to eq({example: 'test', archived_view: 'true'})
    end

    it 'should return the original params if archived_view param is present and set archived_view to nil' do
      params = {example: 'test', archived_view: 'true'}
      expect(helper.archived_view_button(params)).to eq({example:'test', archived_view: nil})
    end
  end

  describe '#archived_button_text' do
    it 'returns "Hide Archived" when archived_view param is present' do
      params = {archived_view: 'true'}
      expect(helper.archived_button_text(params)).to eq '<i class="fa fa-refresh"></i> Hide Archived'
    end

    it 'returns "View Archived" when archived_view param is not present' do
      params = {}
      expect(helper.archived_button_text(params)).to eq '<i class="fa fa-refresh"></i> View Archived'
    end
  end

  describe '#past_tense_actions' do
    it 'sets the past tense of "create" to "created"' do
      expect(helper.past_tense_actions('create')).to eq 'created'
    end

    it 'sets the past tense of "update" to "updated"' do
      expect(helper.past_tense_actions('update')).to eq 'updated'
    end

    it 'sets the past tense of "destroy" to "destroyed"' do
      expect(helper.past_tense_actions('destroy')).to eq 'destroyed'
    end
  end

  describe '#indefinite_articlerize' do
    it 'starts a word with "an" if the letter is a vowel' do
      expect(helper.indefinite_articlerize('amazing')).to eq 'an amazing'
    end

    it 'starts a word with "a" if the letter is not a vowel' do
      expect(helper.indefinite_articlerize('great')).to eq 'a great'
    end
  end

  describe '#public_activity_icon' do
    it 'returns the class for the create action' do
      expect(helper.public_activity_icon('create')).to eq 'fa fa-plus green'
    end

    it 'returns the class for the update action' do
      expect(helper.public_activity_icon('update')).to eq 'fa fa-pencil green'
    end

    it 'returns the class for the destroy action' do
      expect(helper.public_activity_icon('destroy')).to eq 'fa fa-trash red'
    end
  end
end
