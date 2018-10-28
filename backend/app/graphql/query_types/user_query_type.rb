# frozen_string_literal: true

module QueryTypes
  UserQueryType = GraphQL::ObjectType.define do
    name "UserQueryType"
    description "The user query type"

    # Retrieve all users
    field :users, types[Types::UserType], function: Functions::FindAll.new(User)

    field :user, Types::UserType do
      description "Retrieve a user by id"
      argument :id, types.ID, "The ID of the user to retrieve"
      resolve ->(obj, args, ctx) {
        User.find(args[:id])
      }
    end
  end
end
