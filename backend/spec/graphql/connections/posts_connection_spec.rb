# frozen_string_literal: true

RSpec.describe Connections::PostsConnection do
  types = GraphQL::Define::TypeDefiner.instance

  let!(:users) { create_list(:user, 3) }
  let!(:posts) { create_list(:post, 3, sender: users.first, receivers: [users.second, users.last]) }

  include_context "Graphql Client"

  it "has a :totalCount field that returns a Int type" do
    expect(subject).to have_field(:totalCount).that_returns(types.Int)
  end

  it "returns the number of nodes" do
    query_result = client.query do
      query do
        postsConnection do
          totalCount
        end
      end
    end

    expect(query_result.data.posts_connection.total_count).to eq(Post.count)
  end
end
