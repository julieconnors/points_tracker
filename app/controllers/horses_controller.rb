class HorsesController < ApplicationController

    get '/horses' do
        if logged_in?
            erb :"/horses/index"
        else
            #Message that says please log in
            redirect "/"
        end
    end

    get '/horses/new' do
        binding.pry
        erb :"/horses/new"
    end

    post '/horses' do
        binding.pry
        if !Horse.find_by(name: params[:name].capitalize)
            @horse = Horse.new(name: params[:name])
            @horse.user_id = session[:user_id]
            @horse.save!

            redirect "/horses/#{@horse.slug}"
        else
            erb :"/horses/error"
        end
    end

    get '/horses/:slug' do
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/show"
    end

    get '/horses/:slug/edit' do
        @horse = Horse.find_by_slug(params[:slug])
        @user = User.find(session[:user_id])
        if @horse.user_id == @user.id
            erb :"/horses/edit"
        else
            erb :"/horses/access-error"
        end
    end

    patch '/horses/:slug' do
        @horse = Horse.find_by_slug(params[:slug])
        @horse.update!(name: params[:name])

        redirect "/horses/#{@horse.slug}"
    end

    delete '/horses/:id' do
        horse = Horse.find(params[:id])
        user = User.find(session[:user_id])
        if horse.user_id == user.id
            horse.destroy

            redirect to "/account"
        else
            erb :"/horses/access-error"
        end
    end
end