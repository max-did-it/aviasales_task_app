class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from AbstractController::ActionNotFound, with: :render_not_found
  private 
    def render_not_found
      render json: { success: false}, status: :not_found
    end

  protected

  def self.default_serializer(serializer = nil)
    @serializer ||= serializer
  end
  
  def default_serializer
    self.class.default_serializer
  end
end
