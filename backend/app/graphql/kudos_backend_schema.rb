# frozen_string_literal: true

KudosBackendSchema = GraphQL::Schema.define do
  use GraphQL::Batch

  mutation(Types::MutationType)
  query(Types::QueryType)
end
