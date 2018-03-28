module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: e.record,
             status: :unprocessable_entity,
             serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end
