RSpec.describe Types::AuthProviderSignupData do
  # available type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :email input field of AuthProviderEmailInput type' do
    # Ensure that the field email is of type AuthProviderEmailInput
    expect(subject).to have_an_input_field(:credentials).of_type(Types::AuthProviderEmailInput)
  end
end