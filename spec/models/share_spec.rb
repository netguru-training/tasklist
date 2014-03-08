require 'spec_helper'

describe Share do
  let!(:user) { FactoryGirl.create :user }
  let!(:list) { FactoryGirl.create :list, user: user }
  let!(:other_user) { FactoryGirl.create :user }
  let!(:share) { Share.create user: other_user, list: list }
  let!(:user_not_shared) { FactoryGirl.create :user }

  specify "should include shared list in users all_lists" do
    other_user.all_lists.should include list
  end

  specify "should not include shared list in other users all_lists" do
    user_not_shared.all_lists.should_not include list
  end
end
