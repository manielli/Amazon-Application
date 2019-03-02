class Api::ApplicationController < ApplicationController
    skip_before_action(:verify_authenticity_token)

    rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def not_found
        render(
            status: 404,
            json: {
                status: 404,
                errors: [{
                    type: "NotFound",
                    message: "No route matches path /#{params[:unmatched]}"
                }]
            }
        )
    end

    private
    def authenticate_user!
        unless current_user.present?
            render json: {status:401}, status: 401
        end
    end

    def record_not_found(error)
        # binding.pry
        render(
            status: 404,
            json: {
                status: 404,
                errors: [{
                    type: error.class.to_s,
                    message: error.message
                }]
            }
        )
    end

    def standard_error(error)
        # binding.pry
        logger.error error.full_message
        render(
            status: 500,
            json:[{
                status: 500,
                errors: [{
                    type: error.class.to_s,
                    message: error.message
                }]
            }]
        )
    end

    def record_invalid(error)
        # binding.pry

        record = error.record
        errors = record.errors.map do |field, message|
            {
                type: error.class.to_s,
                record_type: record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            status: 422, 
            json: {
                status: 422,
                errors: errors
            }
        )
    end
end
