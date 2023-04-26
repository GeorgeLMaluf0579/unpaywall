# frozen_string_literal: true

class ResultParser
  def self.parse(json_results)
    results = JSON.parse(json_results)
    pdf_results = results['results'].select{ |r| r['response']['best_oa_location']['url_to_pdf'].present? }
    byebug
  end
end