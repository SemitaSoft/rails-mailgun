class ListsController < ApplicationController
  def index
    @total = get_mailing_lists
  end

  def single
    @list = list_members(params[:email])

    respond_to do |format|
      format.html {}
      format.json { render json: @list["items"]}
    end
  end

  private

  def list_members(list)
    response = RestClient.get("https://api:#{ENV["API_KEY"]}" \
                 "@api.mailgun.net/v3/lists/#{list}/members/pages")
    if response.code == 200 
    JSON.parse(response.body)
    else
      return 0
    end
  end

  def get_mailing_lists
    response = RestClient.get("https://api:#{ENV["API_KEY"]}" \
                 "@api.mailgun.net/v3/lists/pages")
    if response.code == 200 
    JSON.parse(response.body)
    else
      return 0
    end
  end
end
