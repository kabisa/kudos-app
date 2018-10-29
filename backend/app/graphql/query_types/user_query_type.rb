# frozen_string_literal: true

module QueryTypes
  UserQueryType = GraphQL::ObjectType.define do
    name "UserQueryType"
    description "The user query type"

    field :users, !types[Types::UserType] do
      description "Retrieve all users"
      argument :name, types.String, "Filter by the name of a user."
      resolve ->(obj, args, ctx) {
        unless args
          User.all
        end

        users = User.all

        if args[:name]
          users = users.where("name LIKE ?", "%#{args[:name]}%")
        end

        users
      }
    end

    field :user, Types::UserType do
      description "Retrieve a user by id"
      argument :id, types.ID, "The ID of the user to retrieve"
      resolve ->(obj, args, ctx) {
        User.find(args[:id])
      }
    end
  end
end
