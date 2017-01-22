require 'spec_helper'

describe Note do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:animal) }
    it { should belong_to(:user) }
  end
end
