# frozen_string_literal: true

RSpec.describe QueryTypes::PostQueryType do
  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  let!(:users) { create_list(:user, 3) }
  let!(:posts) { create_list(:post, 3, sender: users.first, receivers: [users.second, users.last]) }

  describe 'querying all posts' do
    it 'has a :posts that returns a Post type' do
      expect(subject).to have_field(:posts).that_returns(!types[Types::PostType])
    end

    it "returns all our created posts" do
      query_result = subject.fields["posts"].resolve(nil, nil, nil)

      # ensure that each of our posts is returned
      posts.each do |post|
        expect(query_result.to_a).to include(post)
      end

      # we can also check that the number of lists returned is the one we created.
      expect(query_result.count).to eq(posts.count)
    end
  end

  describe 'querying a specific post by id' do
    it 'returns the queried post' do
      id = posts.first.id
      args = { id: id }
      query_result = Functions::FindById.new(Post).call(nil, args, nil)
      expect(query_result).to eq(posts.first)
    end
  end
end
