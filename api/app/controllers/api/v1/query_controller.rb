# frozen_string_literal: true

class Api::V1::QueryController < ApplicationController
  BASE_URL = "https://api.unpaywall.org/v2/search"

  def search
    search_params = { query: params[:expression],
                      is_oa: true,
                      email: params[:email] }
    response = Faraday.get(BASE_URL, search_params)
    if response.status == 200
      pdf_results = ResultParser.parse(response.body)
      DoiProcessorService.new.process(params[:expression], pdf_results)
      render json: DoiBlueprinter.render(Doi.where(expression: params[:expression])), status: :ok
    end
  end
end
