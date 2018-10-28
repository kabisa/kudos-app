# frozen_string_literal: true

module QueryTypes
  PostQueryType = GraphQL::ObjectType.define do
    name "PostQueryType"
    description "The post query type"

    connection :postsConnection, Connections::PostsConnection, function: Functions::FindAll.new(Post) do
      argument :orderBy, types.String, "Column to order the results by", as: :order_by, default_value: "created_at desc"
    end

    field :post, Types::PostType do
      description "Retrieve a post by id"

      argument :id, types.ID, "The ID of the post to retrieve"
      resolve ->(obj, args, ctx) { Post.find(args[:id]) }
    end
  end
end
