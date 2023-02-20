class Api::V1::CertificatesController < ApplicationController
  # before_action :authenticate_api_v1_user!, only: %i[index]

  def index
    @certificates = Certificate.all
    render json: { status: 200, certificates: @certificates.as_json }
  end
end
