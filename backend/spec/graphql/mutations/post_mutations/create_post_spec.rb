RSpec.describe Mutations::PostMutation, ':createPost' do
  let(:users) { create_list(:user, 2) }

  it 'creates a new post' do
    args = {
        receivers: [users.last.name],
        message: Faker::Company.bs,
        kudos: rand(0..500)
    }
    ctx = { current_user: users.first }

    expect {
      subject.fields['createPost'].resolve(nil, args, ctx)
    }.to change { Post.count }.by(1)
  end

  it 'raises an ExecutionError if user is not authenticated' do
    args = {
      receivers: [users.last.name],
      message: Faker::Company.bs,
      kudos: rand(0..500)
    }
    ctx = { current_user: nil }

    expect do
      subject.fields['createPost'].resolve(nil, args, ctx)
    end.to raise_error(GraphQL::ExecutionError, 'Authentication required')
  end
end