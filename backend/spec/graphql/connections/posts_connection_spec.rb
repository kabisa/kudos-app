RSpec.describe Connections::PostsConnection do
  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance
  let!(:users) { create_list(:user, 3) }
  let!(:posts) { create_list(:post, 3, sender: users.first, receivers: [users.second, users.last]) }
  it 'has a :totalCount field that returns a Int type' do
    expect(subject).to have_field(:totalCount).that_returns(types.Int)
  end
  xit 'returns the number of nodes' do
    #TODO write this test
  end
end