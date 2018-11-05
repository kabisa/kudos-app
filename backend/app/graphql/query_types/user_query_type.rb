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

    # find user by id
    field :user, Types::UserType, function: Functions::FindById.new(User)
  end
end
