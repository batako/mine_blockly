class Blocklies::WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:edit, :update, :destroy]

  def new
  end

  def edit
  end

  def create
    @status =
      if Workspace.new(workspace_params).save
        "success"
      else
        "failure"
      end
    set_valiables
  end

  def update
    @status =
      if @workspace.update(workspace_params)
        "success"
      else
        "failure"
      end
    set_valiables
  end

  def destroy
    @workspace.destroy
    set_valiables
  end

  private
    def set_workspace
      @workspace = Workspace.find(params[:id])
    end

    def set_valiables
      @workspaces = Workspace.order(id: :desc).all
    end

    def workspace_params
      params.require(:workspace).permit(:name, :xml)
    end
end
