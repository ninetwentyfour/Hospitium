require 'spec_helper'

describe "notes/new" do
  before(:each) do
    assign(:note, stub_model(Note,
      :uuid => "MyString",
      :note => "MyText",
      :animal => "",
      :user => ""
    ).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path, :method => "post" do
      assert_select "input#note_uuid", :name => "note[uuid]"
      assert_select "textarea#note_note", :name => "note[note]"
      assert_select "input#note_animal", :name => "note[animal]"
      assert_select "input#note_user", :name => "note[user]"
    end
  end
end
