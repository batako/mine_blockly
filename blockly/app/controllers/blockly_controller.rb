class BlocklyController < ApplicationController
  def index
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
end
