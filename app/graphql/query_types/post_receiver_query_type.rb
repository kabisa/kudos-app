module QueryTypes
  PostReceiverQueryType = GraphQL::ObjectType.define do
    name 'PostReceiverQueryType'
    description 'The post receiver query type'

    field :postReceivers, !types[Types::PostReceiverType] do
      description 'Retrieve all postreceivers'

      resolve ->(obj, args, ctx) { PostReceiver.all }
    end
  end
end