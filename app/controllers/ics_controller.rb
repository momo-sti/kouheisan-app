class IcsController < ApplicationController
  def search
    query = params[:query]
    ics = Ic.where("name LIKE ? OR furigana LIKE ?", "%#{query}%", "%#{query}%")
    render json: ics
  end
end
