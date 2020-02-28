require 'rails_helper'
require 'ostruct'
RSpec.describe Users::ProgramsController, type: :request do
  describe "subscribe user on program" do
    subject { post "/users/#{user.id}/programs", params: { program: {id: program.id}} }
    context "when parameters valid" do
      let(:user) { create(:user) }
      let(:program) { create(:program) }
      before do
        subject
      end
      it "should add program to user_programs" do
        expect(response.status).to match(201)
        get "/users/#{user.id}/programs"
        expect(program.id).to be_in(JSON.parse(response.body))
      end
    end
    context "when program not exist" do
      let(:user) { create(:user) }
      let(:program) { OpenStruct.new(id: 123) }
      before do
        Program.delete_all
        subject
      end

      it "should return 404" do
        puts response.body
        expect(response.status).to be(404)
      end
    end
  end
  
  describe "getting user programs" do
    subject { get "/users/#{user.id}/programs" } 
    let(:user) { create(:user) }
    context "when programs exists" do
      before do
        progs = create_list(:program, 10)
        user.programs << progs
        subject
      end
      it "should return array of users" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        body.each do |program|
          expect(program).to be_a(Integer)
        end
      end
    end
    context "when programs not exists" do
      before do
        Program.delete_all 
        subject
      end
      it "should return array of programs" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        expect(body).to be_empty
      end
    end
  end
end
