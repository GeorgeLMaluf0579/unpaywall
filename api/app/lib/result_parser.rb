# frozen_string_literal: true

class ResultParser
  def self.parse(json_results)
    results = JSON.parse(json_results)
    results['results'].select{ |r| r['response']['best_oa_location']['url_for_pdf'].present? }
  end
end