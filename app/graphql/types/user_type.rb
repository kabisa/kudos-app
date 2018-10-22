module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'

    field :id, !types.ID
    field :name, !types.String
    field :email, !types.String

    field :sentPosts, !types[Types::PostType] do
      preload :sent_posts

      resolve ->(obj, args, ctx) {obj.sent_posts }
    end
    field :receivedPosts, !types[Types::PostType] do
      preload :received_posts

      resolve ->(obj, args, ctx) {obj.received_posts }
    end
  end
end
