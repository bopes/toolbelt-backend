class FlagsController < ApplicationController
  def create
    flag = Flag.create(flagger_id: params[:flagger_id], flagee_id: params[:flagee_id], reason: params[:reason])
    render json: flag
  end
end
