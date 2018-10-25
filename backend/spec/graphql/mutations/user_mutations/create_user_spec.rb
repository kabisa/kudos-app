# frozen_string_literal: true

RSpec.describe Mutations::UserMutation, ":createUser" do
  args = {
    name: Faker::Name.first_name,
    authProvider: {
      credentials: {
        email: Faker::Internet.email,
        password: "password"
      }
    }
  }

  it "creates a new user" do
    expect {
      subject.fields["createUser"].resolve(nil, args, nil)
    }.to change { User.count }.by(1)
  end

  it "returns a valid token" do
    result = subject.fields["createUser"].resolve(nil, args, nil)
    token = result.dig("token")
    expect(AuthToken.new.verify(token).keys).to eq([:ok])
  end

  it "token matches user" do
    result = subject.fields["createUser"].resolve(nil, args, nil)
    token = result.dig("token")
    payload = AuthToken.new.verify(token)
    user_id = result.dig("user").id
    expect(payload.dig(:ok, :id)).to eq(user_id)
  end
end
