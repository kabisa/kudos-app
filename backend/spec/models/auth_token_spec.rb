# frozen_string_literal: true

RSpec.describe AuthToken, type: :model do
  let(:user) { create(:user) }

  it "produces a token" do
    expect(subject.token(user)).not_to be_nil
  end

  it "verifies a token" do
    token = subject.token(user)
    expect(subject.verify(token)).not_to be_nil
  end

  it "returns the right payload" do
    token = subject.token(user)
    result = subject.verify(token)
    expect(result.dig(:ok, :id)).to eq(user.id)
  end

  describe "check expiry" do
    context "when token has not expired" do
      it "payload is ok" do
        token = subject.token(user)
        expect(subject.verify(token).dig(:ok)).to be_truthy
      end
    end

    context "when token has expired" do
      it "payload is an error" do
        token = subject.token(user)
        Timecop.freeze(Time.now + 2.days) do
          expect(subject.verify(token).dig(:ok)).not_to be_truthy
        end
      end
    end
  end
end
