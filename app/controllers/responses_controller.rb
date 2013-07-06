class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end

end
