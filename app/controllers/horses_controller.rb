class HorsesController < ApplicationController

    get '/horses' do
        logged_out_redirection
        @user = current_user
            
        erb :"/horses/index"
    end

    get '/horses/new' do
        logged_out_redirection
        
        erb :"/horses/new"
    end

    post '/horses' do
        logged_out_redirection #do I need login validation on post routes??
        if !Horse.find_by(name: params[:name].capitalize)
            @horse = Horse.new(name: params[:name])
            @horse.user_id = session[:user_id]
            @horse.save!

            redirect "/horses/#{@horse.slug}"
        else
            erb :"/horses/duplicate-error" # this should be a redirection
        end
    end

    get '/horses/:slug' do
        logged_out_redirection
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/show"
    end

    get '/horses/:slug/edit' do
        logged_out_redirection
            
        @horse = Horse.find_by_slug(params[:slug])
        @user = User.find(session[:user_id])
        if @horse.user_id == @user.id
            erb :"/horses/edit"
        else
            erb :"/access-error"
        end
    end

    patch '/horses/:slug' do
        logged_out_redirection # is this necessary
        @horse = Horse.find_by_slug(params[:slug])
        if @horse.user_id == current_user.id
            @horse.update(name: params[:name])

            redirect "/horses/#{@horse.slug}"
        else
            redirect "/access-error" # is this necessary
        end
    end

    delete '/horses/:id' do
        logged_out_redirection #is this necessary??
        horse = Horse.find(params[:id])
        if horse.user_id == current_user.id
            horse.destroy

            redirect "/users/#{current_user.slug}"
        else
            redirect "/access-error"
        end
    end
end