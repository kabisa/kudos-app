# frozen_string_literal: true

module QueryTypes
  PostQueryType = GraphQL::ObjectType.define do
    name "PostQueryType"
    description "The post query type"

    field :posts, !types[Types::PostType] do
      description "Retrieve all posts"

      resolve ->(obj, args, ctx) { Post.all }
    end

    # find post by id
    field :post, Types::PostType, function: Functions::FindById.new(Post)
  end
end
