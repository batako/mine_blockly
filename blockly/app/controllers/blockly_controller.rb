class BlocklyController < ApplicationController
  def index
  end

  def run
    File.open('/dev/shm/minetest-message', 'w') do |file|
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
