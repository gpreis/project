module V1
  module Admin
    class TransmissionsController < ApplicationController
      def index
        transmissions = find_all_transmissions(params[:page])

        render json: transmissions
      end

      def create
        transmission = Transmission.create! transmission_params

        render json: transmission, status: :created
      end

      def show
        transmission = find_transmission(params[:id])

        render json: transmission
      end

      def destroy
        find_transmission(params[:id]).destroy!

        head :no_content
      end

      private

      def find_all_transmissions(page)
        Transmission.page(page)
      end

      def find_transmission(id)
        Transmission.find(id)
      end

      def transmission_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(
          params,
          only: %i[name description status]
        )
      end
    end
  end
end
