class BlockliesController < ApplicationController
  before_action :create_blockly_mod_home, only: :run

  def index
    @workspaces = Workspace.order(id: :desc).all
  end

  def run
    File.open("#{Settings.minetest.blockly_mod_home}/admin", 'a') do |file|
      codes.each do |code|
        file.puts code
      end
    end

    render json: { status: 'success' }
  end

  private
    def codes
      params[:codes] || []
    end

    def create_blockly_mod_home
      FileUtils.mkdir_p Settings.minetest.blockly_mod_home
    end
end
