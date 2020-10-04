class HorsesController < ApplicationController

    get '/horses' do
        if logged_in?
            erb :"/horses/index"
        else
            #Message that says please log in
            redirect "/login"
        end
    end

    get '/horses/new' do
        if logged_in?
            erb :"/horses/new"
        else
            redirect "/login"
        end
    end

    post '/horses' do
        #do I need login validation on post routes??
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
        if logged_in?
            @horse = Horse.find_by_slug(params[:slug])

            erb :"/horses/show"
        else
            redirect "/login"
        end
    end

    get '/horses/:slug/edit' do
        if logged_in?
            @horse = Horse.find_by_slug(params[:slug])
            @user = User.find(session[:user_id])
            if @horse.user_id == @user.id
                erb :"/horses/edit"
            else
                erb :"/horses/access-error"
            end
        else
            redirect "/login"
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