class BlockliesController < ApplicationController
  before_action :create_blockly_mod_home, only: :run

  def index
    @user = User.current
    @workspaces = Workspace._mine.or(Workspace._theirs._share).all
  end

  def run
    File.open("#{Settings.minetest.blockly_mod_home}/#{current_user.login_id}", 'a') do |file|
      codes.each do |code|
        file.puts code.gsub('@LOGIN_ID', current_user.login_id)
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
