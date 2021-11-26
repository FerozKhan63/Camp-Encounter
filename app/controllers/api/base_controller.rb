class Api::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :verify_authenticity_token

  private

  def record_not_found
    render json: { error: "Record was not found" }
  end
end
