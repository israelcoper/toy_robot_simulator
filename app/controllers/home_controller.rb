class HomeController < ApplicationController
  def index
  end

  def report
    input = {
      latitude: params[:latitude].to_i,
      longitude: params[:longitude].to_i,
      direction: params[:direction],
      commands: params[:commands].split(',')
    }

    simulator = ToyRobotSimulatorService.new input

    json = {
      input: "PLACE #{input[:latitude]}, #{input[:longitude]}, #{input[:direction]}, #{input[:commands].join(' ')}",
      valid_moves: false
    }

    if simulator.calculate
      json[:valid_moves] = true
      json[:output] = simulator.output
    else
      json[:output] = "Invalid moves!"
    end

    render json: json
  end
end
