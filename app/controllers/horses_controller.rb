class HorsesController < ApplicationController

    get '/horses' do
        erb :"/horses/index"
    end

    get '/horses/new' do
        erb :"/horses/new"
    end

    post '/horses' do
        if !Horse.find_by(name: params[:name].capitalize)
            @horse = Horse.new(name: params[:name])
            @horse.user_id = session[:user_id]
            @horse.save

            redirect "/horses/#{@horse.slug}"
        else
            erb :"/horses/error"
        end
    end

    get '/horses/:slug' do
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/show"
    end

    delete '/horses/:id' do
        binding.pry
        horse = Horse.find(params[:id])
        horse.destroy

        redirect to "/account"
    end
end