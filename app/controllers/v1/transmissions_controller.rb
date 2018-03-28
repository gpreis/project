module V1
  class TransmissionsController < ApplicationController
    def index
      transmissions = find_transmissions(index_status_scope(params[:scope]),
                                         params[:page])

      render json: transmissions
    end

    def show
      transmission = find_started_transmission(params[:id])

      render json: transmission
    end

    private

    def index_status_scope(scope)
      return scope if Transmission::STATUS.include? scope

      :default_scoped
    end

    def find_transmissions(scope, page)
      Transmission.send(scope).page(page)
    end

    def find_started_transmission(id)
      Transmission.started.find(id)
    end
  end
end
