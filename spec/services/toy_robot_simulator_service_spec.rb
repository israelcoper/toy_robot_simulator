require 'rails_helper'

RSpec.describe ToyRobotSimulatorService, type: :model do
    context "instance methods" do
        describe "with valid inputs" do
            let(:valid_input_1) { { latitude: 0, longitude: 0, direction: 'NORTH', commands: ['MOVE'] } }
            let(:valid_input_2) { { latitude: 0, longitude: 0, direction: 'NORTH', commands: ['LEFT'] } }
            let(:valid_input_3) { { latitude: 1, longitude: 2, direction: 'EAST', commands: ['MOVE', 'MOVE', 'LEFT', 'MOVE'] } }

            let(:robot_1) { ToyRobotSimulatorService.new valid_input_1 }
            let(:robot_2) { ToyRobotSimulatorService.new valid_input_2 }
            let(:robot_3) { ToyRobotSimulatorService.new valid_input_3 }

            describe "#calculate" do
                it "returns true" do
                    expect(robot_1.calculate).to eq true
                    expect(robot_2.calculate).to eq true
                    expect(robot_3.calculate).to eq true
                end
            end

            describe "#move" do
                it "returns the updated latitude and longitude" do
                    expect(robot_1.move).to eq [0, 1]
                    expect(robot_2.move).to eq [0, 1]
                    expect(robot_3.move).to eq [2, 2]
                end
            end

            describe "#rotate" do
                it "returns the updated direction" do
                    expect(robot_1.rotate).to eq "WEST"
                    expect(robot_2.rotate).to eq "WEST"
                    expect(robot_3.rotate).to eq "NORTH"
                end
            end

            describe "#valid_move?" do
                it "returns true" do
                    robot_1.calculate
                    robot_2.calculate
                    robot_3.calculate

                    expect(robot_1.valid_move?).to eq true
                    expect(robot_2.valid_move?).to eq true
                    expect(robot_3.valid_move?).to eq true
                end
            end

            describe "#output" do
                it "returns valid output" do
                    robot_1.calculate
                    robot_2.calculate
                    robot_3.calculate

                    expect(robot_1.output).to eq "0, 1, NORTH"
                    expect(robot_2.output).to eq "0, 0, WEST"
                    expect(robot_3.output).to eq "3, 3, NORTH"
                end
            end
        end

        describe "with invalid inputs" do
            let(:invalid_input_1) { { latitude: 0, longitude: 0, direction: 'SOUTH', commands: %w{ MOVE } } }
            let(:invalid_input_2) { { latitude: 2, longitude: 1, direction: 'EAST', commands: %w{ MOVE MOVE MOVE LEFT LEFT MOVE } } }
            let(:invalid_input_3) { { latitude: 3, longitude: 2, direction: 'NORTH', commands: %w{ MOVE MOVE RIGHT MOVE MOVE } } }

            let(:robot_1) { ToyRobotSimulatorService.new invalid_input_1 }
            let(:robot_2) { ToyRobotSimulatorService.new invalid_input_2 }
            let(:robot_3) { ToyRobotSimulatorService.new invalid_input_3 }

            describe "#calculate" do
                it "returns false" do
                    expect(robot_1.calculate).to eq false
                    expect(robot_2.calculate).to eq false
                    expect(robot_3.calculate).to eq false
                end
            end

            describe "#move" do
                it "returns the updated latitude and longitude" do
                    expect(robot_1.move).to eq [0, -1]
                    expect(robot_2.move).to eq [3, 1]
                    expect(robot_3.move).to eq [3, 3]
                end
            end

            describe "#rotate" do
                it "returns the updated direction" do
                    expect(robot_1.rotate).to eq "EAST"
                    expect(robot_2.rotate).to eq "NORTH"
                    expect(robot_3.rotate).to eq "WEST"
                end
            end

            describe "#valid_move?" do
                it "returns false" do
                    robot_1.calculate
                    robot_2.calculate
                    robot_3.calculate

                    expect(robot_1.valid_move?).to eq false
                    expect(robot_2.valid_move?).to eq false
                    expect(robot_3.valid_move?).to eq false
                end
            end

            describe "#output" do
                it "returns the invalid output" do
                    robot_1.calculate
                    robot_2.calculate
                    robot_3.calculate

                    expect(robot_1.output).to eq "0, -1, SOUTH"
                    expect(robot_2.output).to eq "5, 1, EAST"
                    expect(robot_3.output).to eq "5, 4, EAST"
                end
            end
        end
    end
end
