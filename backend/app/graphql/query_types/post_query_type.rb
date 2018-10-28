# frozen_string_literal: true

module QueryTypes
  PostQueryType = GraphQL::ObjectType.define do
    name "PostQueryType"
    description "The post query type"

    connection :postsConnection, Connections::PostsConnection, function: Functions::FindAll.new(Post) do
      argument :orderBy, types.String, "Column to order the results by", as: :order_by, default_value: "created_at desc"
    end

    # find post by id
    field :post, Types::PostType, function: Functions::FindById.new(Post)
  end
end
