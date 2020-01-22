# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  role       :integer          default("guest"), not null
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  login_id   :string           not null
#
# Indexes
#
#  index_users_on_login_id  (login_id) UNIQUE
#  index_users_on_token     (token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'factory'

  describe "User.authenticate!" do
    subject { User.authenticate!(user.login_id) }
    let(:user) { create :user }

    it "works" do
      expect(subject.token).to_not eq nil
      expect(subject.token).to eq user.reload.token
    end
  end

  describe "User.current" do
    subject { User.current }
    let(:user) { create :user }
    before { User.current = user }

    it "works" do
      expect(subject.id).to eq user.id
    end
  end

  describe "#generate_token!" do
    subject { user.generate_token! }
    let(:user) { create :user }
    before { subject }

    it "works" do
      expect(user.reload.token).to_not eq nil
    end
  end
end
