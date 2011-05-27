require 'spec_helper'

describe Reshare do
  it 'has a valid Factory' do
    Factory(:reshare).should be_valid
  end

  it 'requires root (original post)' do
    reshare = Factory.build(:reshare, :root => nil)
    reshare.should_not be_valid
  end

  it 'requires ancestor' do
    reshare = Factory.build(:reshare, :ancestor => nil)
    reshare.should_not be_valid
  end

  it 'require public root' do
    Factory.build(:reshare, :root => Factory.create(:status_message, :public => false)).should_not be_valid
  end

  it 'does not let you reshare a reshare' do
    r1 = Factory.create(:reshare)
    reshare = Factory.build(:reshare, :root => r1).should_not be_valid
  end

  it 'does not let you reshare your own post' do
    person = Factory.create(:person)
    reshare = Factory.build(:reshare, :author => person, :root => Factory.create(:status_message, :author => person, :public => true)).should_not be_valid
  end

  it 'forces public' do
    Factory(:reshare, :public => false).public.should be_true
  end
end
