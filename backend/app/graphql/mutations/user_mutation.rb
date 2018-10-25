# frozen_string_literal: true

module Mutations
  UserMutation = GraphQL::ObjectType.define do
    name "UserMutation"
    description "All user related mutations"

    field :createUser, Types::UserType do
      description "Create a new user"
      argument :name, !types.String
      argument :authProvider, !Types::AuthProviderSignupData

      # define return type
      type Types::AuthenticateType


      resolve ->(_obj, args, _ctx) do
        user = User.create!(
          name: args[:name],
          email: args[:authProvider][:credentials][:email],
          password: args[:authProvider][:credentials][:password]
        )

        OpenStruct.new(
          token: AuthToken.new.token(user),
          user: user
        )
      end
    end

    field :signInUser, Types::UserType do
      description "Sign in a user"
      # define the arguments this field will receive
      argument :credentials, !Types::AuthProviderEmailInput

      # define what this field will return
      type Types::AuthenticateType

      # resolve the field's response
      resolve ->(_obj, args, ctx) do
        input = args[:credentials]
        return unless input

        user = User.find_by(email: input[:email])
        return unless user
        return unless user.authenticate(input[:password])

        OpenStruct.new(
          token: AuthToken.new.token(user),
          user: user
        )
      end
    end
  end
end
