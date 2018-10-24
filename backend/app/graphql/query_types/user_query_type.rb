module QueryTypes
  UserQueryType = GraphQL::ObjectType.define do
    name 'UserQueryType'
    description 'The user query type'

    field :users, !types[Types::UserType] do
      description 'Retrieve all users'
      resolve ->(obj, args, ctx) {
        User.all
      }
    end

    field :user, Types::UserType do
      description 'Retrieve a user by id'
      argument :id, types.ID, 'The ID of the user to retrieve'
      resolve ->(obj, args, ctx) {
        User.find(args[:id])
      }
    end
  end
end