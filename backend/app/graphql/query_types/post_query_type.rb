# frozen_string_literal: true

module QueryTypes
  PostQueryType = GraphQL::ObjectType.define do
    name "PostQueryType"
    description "The post query type"

    field :posts, !types[Types::PostType] do
      description "Retrieve all posts"

      resolve ->(obj, args, ctx) { Post.all }
    end

    field :post, Types::PostType do
      description "Retrieve a post by id"

      argument :id, types.ID, "The ID of the post to retrieve"
      resolve ->(obj, args, ctx) { Post.find(args[:id]) }
    end
  end
end
