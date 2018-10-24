# module Types
#   MutationType = GraphQL::ObjectType.define do
#     name "Mutation"
#
#     field :signInUser, function: Mutations::SignInUser.new
#     field :createUser, function: Mutations::CreateUser.new
#   end
# end

module Types
  MutationType = GraphQL::ObjectType.new.tap do |root_type|
    root_type.name = 'Mutation'
    root_type.description = 'The mutation root'
    root_type.interfaces = []
    root_type.fields = Util::FieldCombiner.combine([
      Mutations::UserMutation,
      Mutations::PostMutation
    ])
  end
end
