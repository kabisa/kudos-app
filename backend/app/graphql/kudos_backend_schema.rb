# frozen_string_literal: true

KudosBackendSchema = GraphQL::Schema.define do
  use GraphQL::Batch

  mutation(Types::MutationType)
  query(Types::QueryType)

  # solution for: https://github.com/rmosolgo/graphql-ruby/issues/1922
  GraphQL::Relay::BaseConnection.register_connection_implementation(ActiveRecord::Relation, GraphQL::Relay::RelationConnection)
end
