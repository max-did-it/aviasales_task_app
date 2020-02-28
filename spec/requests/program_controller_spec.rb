require 'rails_helper'
require 'ostruct'
RSpec.describe ProgramsController, type: :request do
  describe "getting programs list" do
    subject { get '/programs' } 
    context "when programs exists" do
      before do 
        create_list(:program, 10)
        subject
      end
      it "should return array of programs" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        body.each do |program|
          expect(program).to be_a(Hash)
          expect(program).to match("id" => be_a(Integer),"title" => be_a(String), "description" => be_a(String))
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
  describe "search programs by terms" do
    subject { get "/programs/search/#{term}" } 
    context "when programs exists" do
      let(:title) { FFaker::Book.title  }
      let(:term) { "cheburek" }
      let(:program) { create(:program, title: (title + term)) }
      before do 
        subject
      end
      it "should return array of programs" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        body.each do |program|
          expect(program).to be_a(Hash)
          expect(program).to match("id" => be_a(Integer),"title" => be_a(String), "description" => be_a(String))
        end
      end
    end
    context "when programs not exists" do
      let(:term) { "cheburek" }
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
  describe "create new program" do
    subject { post "/programs", params: parameters } 
    context "when parameters valid" do
      let(:parameters) {
        { 
          program: {
            title: FFaker::Book.title,
            description: FFaker::Book.description[0,200]
          } 
        }
      }
      before do 
        subject
      end
      it "should return created program" do
        body = JSON.parse(response.body)
        expect(body).to be_a(Hash)
        expect(body.dig("program")).to match("id" => be_a(Integer),"title" => be_a(String), "description" => be_a(String))
        expect(body.dig("program","title")).to  eql(parameters.dig(:program, :title))
        expect(body.dig("program","description")).to eql(parameters.dig(:program, :description))
      end
    end
    context "when parameters invalid" do
      let(:parameters) {
        { 
          program: {
            title: []
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
