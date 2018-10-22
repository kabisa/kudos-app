RSpec.describe PostReceiver, type: :model do
  let(:user) { create(:user) }
  let(:receiver) { create(:user) }
  let(:post) { create(:post, sender: user, receivers: [user]) }

  it 'should have a valid factory' do
    expect(build(:post_receiver, user_id: receiver.id, post_id: post.id)).to be_valid
  end

  let(:post_receiver) { create(:post_receiver, user_id: receiver.id, post_id: post.id) }

  describe 'model validations' do
    #  ensure that the user_id field is unique for each post_id
    it { expect(post_receiver).to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe 'model associations' do
    # ensure that a post_receiver belongs to a post
    it { expect(post_receiver).to belong_to(:post) }
    # ensure that a post_receiver belongs to a user
    it { expect(post_receiver).to belong_to(:user) }
  end
end