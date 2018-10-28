# frozen_string_literal: true

RSpec.describe Functions::FindAll do
  let(:users) { create_list(:user, 10) }

  context "existing records are provided" do
    it "returns all records with no argument given" do
      query_result = Functions::FindAll.new(User).call(nil, nil, nil)
      expect(query_result).to eq(users)
    end

    it "returns all records with argument given" do
      create_list(:post, 10, sender: users.first, receivers: [users.second, users.last])
      args = { order_by: "created_at desc" }
      query_result = Functions::FindAll.new(Post).call(nil, args, nil)

      expect(query_result).to eq(Post.all.order("created_at desc"))
    end
  end

  context "when no records exist" do
    it "returns an empty array" do
      query_result = Functions::FindAll.new(User).call(nil, nil, nil)

      expect(query_result).to be_empty
    end
  end
end
