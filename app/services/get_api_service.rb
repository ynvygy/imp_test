class GetApiService
  # Could be required if it expands
  # def initialize(link)
  #   @link = link
  # end

  def make_api_call
    Faraday.get(@link)
  end
end
