class CertificatesController < ApplicationController
  def index
    @certificates = Certificate.all
    render json: { status: 200, certificates: @certificates.as_json }
  end
end
