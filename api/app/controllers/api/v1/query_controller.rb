# frozen_string_literal: true

class Api::V1::QueryController < ApplicationController
  BASE_URL = "https://api.unpaywall.org/v2/search"

  def search
    search_params = {query: params[:expression],
                     is_oa: true,
                     email: params[:email]}
    response = Faraday.get(BASE_URL, search_params)
    if response.status == 200
      ResultParser.parse(response.body)
    end
  end
end
