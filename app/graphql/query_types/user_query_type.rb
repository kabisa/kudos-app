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

    # find user by id
    field :user, Types::UserType, function: Functions::FindById.new(User)
  end
end