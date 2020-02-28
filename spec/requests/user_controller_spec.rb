require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "getting users list" do
    subject { get '/users' } 
    context "when programs exists" do
      before do 
        create_list(:user, 10)
        subject
      end
      it "should return array of programs" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        body.each do |user|
          expect(user).to be_a(Hash)
          expect(user).to match("id" => be_a(Integer),"name" => be_a(String), "email" => be_a(String))
        end
      end
    end
    context "when users not exists" do
      before do
        User.delete_all 
        subject
      end
      it "should return empty array" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        expect(body).to be_empty
      end
    end
  end

  describe "create new user" do
    subject { post "/users", params: parameters } 
    context "when parameters valid" do
      let(:parameters) {
        { 
          user: {
            name: FFaker::Internet.user_name,
            email: FFaker::Internet.unique.email
          } 
        }
      }
      before do 
        subject
      end
      it "should return created user" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Hash)
        expect(body.dig("user")).to match("id" => be_a(Integer),"email" => be_a(String), "name" => be_a(String))
        expect(body.dig("user","email")).to  eql(parameters.dig(:user, :email))
        expect(body.dig("user","name")).to eql(parameters.dig(:user, :name))
      end
    end
    context "when parameters invalid" do
      let(:parameters) {
        { 
          user: {
            email: []
          } 
        }
      }
      before do 
        subject
      end
      it "should return errors" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Hash)
        expect(body.dig("errors")).to be
      end
    end
  end  
end
