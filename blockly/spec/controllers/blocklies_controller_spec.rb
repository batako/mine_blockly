require 'rails_helper'

RSpec.describe BlockliesController, type: :controller do

  let(:valid_attributes) {
    {codes: ["test code 1", "test code 2"]}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #run" do
    before do
      if Dir.exist?(Settings.minetest.blockly_mod_home)
        FileUtils.rm_r(Settings.minetest.blockly_mod_home)
      end

      post :run, params: valid_attributes, session: valid_session, xhr: true
    end

    it "returns a success response" do
      expect(response).to be_success
    end

    it "creates a blockly codes file" do
      File.open(
        Dir.glob("#{Settings.minetest.blockly_mod_home}/*").first
      ) do |file|
        file.each_with_index do |line, index|
          expect(line.chomp).to eq valid_attributes[:codes][index]
        end
      end
    end
  end

end
