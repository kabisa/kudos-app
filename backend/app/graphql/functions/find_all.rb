# frozen_string_literal: true

class Functions::FindAll < GraphQL::Function
  attr_reader :model_class

  def initialize(model_class)
    @model_class = model_class
  end

  description "Retrieve all resources"

  def call(_obj, args, _ctx)
    if !args.nil?
      @model_class.all.order(args[:order_by]) if args[:order_by]
    else
      @model_class.all
    end
  end
end
