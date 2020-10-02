class PrizesController < ApplicationController
    get '/prizes/new' do
        erb :"/prizes/new"
    end

    post '/prizes' do
        @horse = Horse.find_or_create_by(name: params[:horse_name])
        @horseshow = Horseshow.find_or_create_by(params[:horseshow])

        @prize = Prize.create(point_total: params[:point_total], horse_id: @horse.id, horseshow_id: @horseshow.id)

        redirect "/account"
    end

end