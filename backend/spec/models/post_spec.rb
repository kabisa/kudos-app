# frozen_string_literal: true

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:receiver) { create(:user) }

  it "should have a valid factory" do
    expect(build(:post, sender: user, receivers: [user])).to be_valid
  end

  let!(:post) { create(:post, sender: user, receivers: [user]) }

  describe "model destroy dependencies" do
    it "should destroy dependent PostReceivers" do
      expect { post.destroy }.to change { PostReceiver.count }
    end
  end

  describe "model validations" do
    # ensure that the sender field is never empty
    it { expect(post).to validate_presence_of(:sender) }
    # ensure that the receivers field is never empty
    it { expect(post).to validate_presence_of(:receivers) }
    # ensure that the message field is never empty
    it { expect(post).to validate_presence_of(:message) }
    # ensure that the kudos field is never empty
    it { expect(post).to validate_presence_of(:kudos) }
    # ensure that the number of kudos is between a specific numericality
    it { expect(post).to validate_numericality_of(:kudos) }
  end

  describe "model associations" do
    # ensure that a user has many sent_posts
    it { expect(post).to belong_to(:sender) }
    # ensure that a user has many post_receivers
    it { expect(post).to have_many(:post_receivers) }
    # ensure that a user has many received_posts through post_receivers
    it { expect(post).to have_many(:receivers).through(:post_receivers) }
  end
end
