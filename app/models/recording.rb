class Recording < ApplicationRecord
  belongs_to :user
  belongs_to :landmark

  validates_presence_of :title, :url

  def total_score(id)
    get_score = conn.get do |req|
      req.url "/api/v1/recording/#{id}/score"
    end
    score = JSON.parse(get_score.body)

    return score["data"]["attributes"]["total_score"]
  end

  private
    def conn
      Faraday.new url: "https://votes-app-1903.herokuapp.com" do  |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
end
