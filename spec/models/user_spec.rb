require 'rails_helper'
require 'pry'
RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(email:"test@gmail.com",password:"123456789",password_confirmation:"123456789")
  end

  describe "creation" do
    it "should have one items created after being created" do
      expect(User.all.count).to eq(1)
    end
  end

  describe "validation" do
    it "should not let a user be created without an email address" do
      @user.email = nil
      expect(@user).to_not be_valid
    end
    it "should not let a user be created without a password" do
    @user.password = nil
    expect(@user).to_not be_valid
    end
  end

  describe "/User/create" do

    def create_User(email,password,password_confirmation)
      post new_user_registration_path, params: {
        User:{
          email: email,
          password: password,
          password: password_confirmation
        }
      }
    end

      context "valid params" do 
        it "successfullly creates a post" do
          expect do
            create_User("testuser@gmail.com","123456789","123456789")
          end.to change {User.count}.from(0).to(1)

          expect(response).to have_http_status(:redirect)
        end
      end

      context "invalid params" do
        it "fails at creating the User" do
          expect{ create_User("use@gmailc.om","","")}.not_to change {User.count}
        expect(User.count).to eq(0)
        expect(response).to have_http_status(:success)
      end
    end
  end


  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}


end
