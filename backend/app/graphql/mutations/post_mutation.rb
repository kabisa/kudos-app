# frozen_string_literal: true

module Mutations
  PostMutation = GraphQL::ObjectType.define do
    name "PostMutation"
    description "All post related mutations"

    field :createPost, Types::PostType do
      description "Create a new post"
      argument :message, !types.String
      argument :kudos, !types.Int
      argument :receivers, !types[types.Int]

      # define return type
      type Types::PostType

      resolve ->(_obj, args, ctx) do
        if ctx[:current_user].blank?
          raise GraphQL::ExecutionError.new("Authentication required")
        end

        post = Post.create!(
          message: args[:message],
          kudos: args[:kudos],
          sender: ctx[:current_user],
          receivers: User.find(args[:receivers])
        )
      end
    end
  end
end
