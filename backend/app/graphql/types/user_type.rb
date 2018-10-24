module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'

    field :id, !types.ID
    field :name, !types.String
    field :email, !types.String

    field :sentPosts, !types[Types::PostType] do
      resolve ->(obj, args, ctx) { Util::RecordLoader.for(User).load_many(obj.sent_posts.ids) }
    end
    field :receivedPosts, !types[Types::PostType] do
      resolve ->(obj, args, ctx) { Util::RecordLoader.for(User).load_many(obj.received_posts.ids) }
    end
  end
end
