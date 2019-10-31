# frozen_string_literal: true

class Functions::FindAll < GraphQL::Function
  attr_reader :model_class

  def initialize(model_class)
    @model_class = model_class
  end

  description "Retrieve all resources"

  def call(_obj, args, _ctx)
    return @model_class.all if args.keys.empty?

    result = @model_class.all
    result = result.order(args[:order]) if args[:order]

    result
  end
end
