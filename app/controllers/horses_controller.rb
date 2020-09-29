class HorsesController < ApplicationController

    get '/horses' do
        erb :"/horses/index"
    end

    get '/horses/new' do
        erb :"/horses/new"
    end

    get '/horses/:slug' do
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/show"
    end

    post '/horses' do
        @horse = Horse.create(name: params[:name])
        @horseshow = Horseshow.create(params[:horseshow])
        @horse.user_id = session[:user_id]
        @prize = Prize.create(point_total: params[:prize], horse_id: @horse.id, horseshow_id: @horseshow.id)
        
        redirect "/horses/#{@horse.slug}"
    end
end