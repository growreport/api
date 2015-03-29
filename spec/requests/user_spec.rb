require "rails_helper"

describe "Users API" do
  describe "GET /users" do
    it "returns all users" do
      user = FactoryGirl.build(:user, username: "tester", email: "dogbones@hungry.com")
      get "/users", nil, { authorization: "Token #{user.auth_token}" }

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['users'].size).to eq(User.count)
    end
  end

  describe 'POST /users' do
    let(:user) { FactoryGirl.build :user }
    context "Valid new user" do
      it "is created" do
        expect { post_users(user) }.to change(User, :count).by(1)
        expect(User.last.email).to eq(user.email)
        expect(User.last.username).to eq(user.username)
        expect(response.status).to eq(201)
      end
    end

    context "Invalid new user" do
      it "is not created" do
        user.email = 'email?'
        expect { post_users(user) }.to_not change(User, :count)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /users/:id" do
    let(:valid_update_attr) { 
      { 
        email: 'newer@email.com', 
        username: 'newestkidontheblock',
        current_password: 'password',  
        password: 'pass',
        password_confirmation: 'pass'
      }
    }
    let(:expected_update_attr) { { email: 'newer@email.com', username: 'newkidontheblock' } }
    let(:action) { put "/users/#{record.id}", { user: valid_update_attr }, {
      authorization: "Token #{record.auth_token}" }
    }
    let!(:record) { FactoryGirl.create :user }
    before { action }
    it {
      record.reload
      expect(response.status).to eq(204) 
      expect(record.email).to eq(expected_update_attr[:email]) 
      expect(record.username).to eq(expected_update_attr[:username]) 
      expect(record.authenticate('pass')).to be_true 
   }
  end

  describe "DELETE /users/:id" do
    let!(:user) { FactoryGirl.create(:user) }
    it "Deletes the user" do
      expect {
        delete "/users/#{user.id}", {}, { authorization: "Token #{user.auth_token}" }
      }.to change(User, :count).by(-1)
    end
  end
end


def post_users(user)
  post "/users", {
    user: {
      username: user.username,
      email: user.email,
      password: user.password,
      password_confirmation: user.password_confirmation
    }
  }
end