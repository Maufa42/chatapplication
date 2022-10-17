require 'rails_helper'

RSpec.describe Room, type: :model do
 
  describe 'creation a Public Rooom' do
    it "should create a public-room after being created" do
      expect(Room.last.private).to be false
    end
  end

  describe 'creation of private Room' do 
    it "should create a private-room when giving attribute" do 
      expect(Room.last.private).to be true
    end
  end

  it {should validate_presence_of(:name)}

  describe "/rooms/new" do
    #Spec
    it"succeeds" do 
    get new_user_path
    expect(response).to have_http_status(:success)
    end
  end
end
