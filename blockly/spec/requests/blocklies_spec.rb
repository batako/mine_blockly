require 'rails_helper'

RSpec.describe BlockliesController, type: :request do
  describe "GET #index" do
    subject { get blocklies_path }

    include_examples "has status code 200"
  end

  describe "POST #run" do
    subject { post run_blocklies_path(params) }

    let(:params) { {codes: ["test code 1", "test code 2"]} }

    before do
      if Dir.exist?(Settings.minetest.blockly_mod_home)
        FileUtils.rm_r(Settings.minetest.blockly_mod_home)
      end
    end

    include_examples "has status code 200"

    it "writes minetest codes to blockly mod file" do
      subject

      File.open(
        Dir.glob("#{Settings.minetest.blockly_mod_home}/*").first
      ) do |file|
        file.each_with_index do |line, index|
          expect(line.chomp).to eq params[:codes][index]
        end
      end
    end
  end

end
