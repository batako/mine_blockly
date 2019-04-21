class Blocklies::Workspaces::EmotionsController < ApplicationController
  before_action :validate_params
  before_action :set_workspace_emotion

  def update
    case params[:type]
    when 'create'
      @workspace_emotion.save!
    when 'delete'
      @workspace_emotion.destroy! unless @workspace_emotion.new_record?
    end
    set_valiables
  end

  private
    def set_workspace_emotion
      @workspace_emotion = WorkspaceEmotion.find_or_initialize_by(
        workspace_id: params[:workspace_id],
        emotion:      params[:emotion],
        user_id:      User.current.try(:id)
      )
    end

    def validate_params
      params.required(:workspace_id)
      params.required(:emotion)
      params.required(:type)
    end

    def set_valiables
      @workspaces = Workspace._mine.or(Workspace._theirs._share).all
    end
end
