require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    let(:valid_moves_test_1) { { latitude: 0, longitude: 0, direction: 'NORTH', commands: "MOVE," } }
    let(:valid_moves_test_2) { { latitude: 0, longitude: 0, direction: 'NORTH', commands: "LEFT" } }
    let(:valid_moves_test_3) { { latitude: 1, longitude: 2, direction: 'EAST', commands: "MOVE,MOVE,LEFT,MOVE," } }

    let(:invalid_moves_test_1) { { latitude: 0, longitude: 0, direction: 'SOUTH', commands: "MOVE," } }
    let(:invalid_moves_test_2) { { latitude: 2, longitude: 1, direction: 'EAST', commands: "MOVE,MOVE,MOVE,LEFT,LEFT,MOVE," } }
    let(:invalid_moves_test_3) { { latitude: 3, longitude: 2, direction: 'NORTH', commands: "MOVE,MOVE,RIGHT,MOVE,MOVE," } }

    describe "GET home#index" do
        it "renders the index page" do
            get :index
            expect(response).to render_template :index
        end
    end

    describe "POST home#report" do
        describe "with valid moves" do
            it "test 1 return valid moves" do
                post :report, params: valid_moves_test_1

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "0, 1, NORTH"
            end

            it "test 2 return valid moves" do
                post :report, params: valid_moves_test_2

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "0, 0, WEST"
            end

            it "test 3 return valid moves" do
                post :report, params: valid_moves_test_3

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "3, 3, NORTH"
            end
        end

        describe "with invalid moves" do
            it "test 1 return invalid moves" do
                post :report, params: invalid_moves_test_1

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "Invalid moves!"
            end

            it "test 2 return invalid moves" do
                post :report, params: invalid_moves_test_2

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "Invalid moves!"
            end

            it "test 3 return invalid moves" do
                post :report, params: invalid_moves_test_3

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:success)
                expect(json["output"]).to eq "Invalid moves!"
            end
        end
    end
end
