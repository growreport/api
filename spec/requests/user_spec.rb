require "rails_helper"

describe "Users API" do
  describe "GET /users" do
    it "returns all users" do
      user = FactoryGirl.build(:user, username: "tester", email: "dogbones@hungry.com")
      get "/users", nil, { authorization: "Token #{user.auth_token}" }

      expect(response).to be_success
      p request.body
      json = JSON.parse(request.body)
      expect(json['user'].size).to eq(4)
      expect(json['user']['username']).to eq("tester")
      expect(json['user']['email']).to eq("dogbones@hungry.com")
    end
  end

  describe 'POST /users' do
    let(:user) { FactoryGirl.create :user }
    context "Valid new user" do
      it "increments the user count" do
        expect {
          post "/users", {
            user: user
          }
        }.to change(User, :count).by(1)
      end

      it "has valid data" do
        post "/users", {
          user: user
        }
        expect(User.last.email).to eq(user.email)
        expect(User.last.username).to eq(user.username)
      end
         
      it "returns 201" do
        post "/users", {
          user: user
        }
        expect(response.status).to eq(201)
      end
    end

    context "Invalid new user" do
      it "is nott added" do
        user.password = 'wh1ops'
        expect { 
          post "/users", {
            user: user
          }
        }.to_not change(User, :count).by(1)
      end

      it "returns 422" do
        user.password = 'whoops'
        post "/users", {
          user: user
        }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /users/:id" do
    let(:user) { FactoryGirl.create :user }
    it "Updates the users email and password" do
      user = FactoryGirl.create(:user)
      email = "dogbones@hungry.com"
      password = "new_password"
      put "/users/#{user.id}",
      { user: {
          current_password: "password",
          email: email,
          password: password,
          password_confirmation: password
      }}, { authorization: "Token #{user.auth_token}" }
      expect(response.status).to eq(204)
      expect(user.reload.email).to eq(email)
      expect(user.reload.authenticate(password)).to eq(user)
    end
  end

  describe "DELETE /users/:id" do
    it "Deletes the user" do
      user = FactoryGirl.create(:user)
      expect {
        delete "/users/#{user.id}", {}, { authorization: "Token #{user.auth_token}" }
      }.to change(User, :count).by(-1)
    end
  end
end
