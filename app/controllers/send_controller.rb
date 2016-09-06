class SendController < ApplicationController
  def index
  end

  def create
    respond_to do |format|
      format.html { render :nothing }
      format.json { render :nothing }
    end
  end
end
