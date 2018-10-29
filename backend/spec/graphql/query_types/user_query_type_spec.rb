# frozen_string_literal: true

RSpec.describe QueryTypes::UserQueryType do
  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  let!(:users) { create_list(:user, 3) }

  describe "querying a specific user by id" do
    it "returns the queried user" do
      # set the id of the first user as the ID
      id = users.first.id
      args = { id: id }
      query_result = subject.fields["user"].resolve(nil, args, nil)

      # we should only get the first user from the db.
      expect(query_result).to eq(users.first)
    end
  end

  describe "querying all users" do
    it "has a :users that returns a User type" do
      expect(subject).to have_field(:users).that_returns(types[Types::UserType])
    end

    it "returns all our created users" do
      args = {}
      query_result = subject.fields["users"].resolve(nil, args, nil)

      # ensure that each of our users is returned
      users.each do |user|
        expect(query_result.to_a).to include(user)
      end

      # we can also check that the number of lists returned is the one we created.
      expect(query_result.count).to eq(users.count)
    end
  end
end
