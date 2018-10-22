module Types
  PostType = GraphQL::ObjectType.define do
    name 'Post'

    field :id, !types.ID
    field :message, !types.String
    field :kudos, !types.Int

    field :sender, !Types::UserType do
      resolve ->(obj, args, ctx) { Util::RecordLoader.for(User).load(obj.sender_id) }
    end

    field :receivers, !types[Types::UserType] do
      preload :receivers
      resolve ->(obj, args, ctx) { obj.receivers }
    end
  end
end