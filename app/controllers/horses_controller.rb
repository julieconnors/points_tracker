class HorsesController < ApplicationController

    get '/horses' do
        erb :"/horses/index"
    end

    get '/horses/new' do
        erb :"/horses/new"
    end

    get '/horses/:id' do
        erb :"/horses/show"
    end

    post '/horses' do
        binding.pry  
        @horse = Horse.create(name: params[:name])
        @horse_show = HorseShow.create(params[:horse_show])
        #assign user_id to @horse

        @prize = Prize.create(point_total: params[:point_total], horse_id: @horse.id, horse_show_id: @horse_show.id)
        #redirect "/horses/show"
    end
end