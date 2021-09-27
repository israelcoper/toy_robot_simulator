class HomeController < ApplicationController
  def index
  end

  def report
    input = {
      latitude: params[:latitude],
      longitude: params[:longitude],
      direction: params[:direction],
      commands: params[:commands].split(',')
    }

    render json: {
      input: "PLACE #{input[:latitude]}, #{input[:longitude]}, #{input[:direction]}, #{input[:commands].join(' ')}",
      output: "X, Y DIRECTION"
    }
  end
end
