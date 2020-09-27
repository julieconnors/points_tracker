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
        @horse = Horse.create(params[:name])
        binding.pry
        @horse_show = HorseShow.create(params[:horse_show])

        @points = Points.create(name: params[:points], horse_id: @horse.id, horse_show_id: @horse_show.id)
        #redirect "/horses/show"
    end
end