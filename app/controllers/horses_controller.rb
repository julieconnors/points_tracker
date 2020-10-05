class HorsesController < ApplicationController

    get '/horses' do
        if logged_in?
            @user = current_user
            
            erb :"/horses/index"
        else
            #Message that says please log in
            redirect "/login" # should this render instead??
        end
    end

    get '/horses/new' do
        if logged_in?
            erb :"/horses/new"
        else
            redirect "/login"  #should this render instead??
        end
    end

    post '/horses' do
        #do I need login validation on post routes??
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
        if logged_in?
            @horse = Horse.find_by_slug(params[:slug])

            erb :"/horses/show"
        else
            redirect "/login" #should this render instead??
        end
    end

    get '/horses/:slug/edit' do
        if logged_in?
            @horse = Horse.find_by_slug(params[:slug])
            @user = User.find(session[:user_id])
            if @horse.user_id == @user.id
                erb :"/horses/edit"
            else
                erb :"/access-error"
            end
        else
            redirect "/login" #should this render instead of redirect??
        end
    end

    patch '/horses/:slug' do
        if logged_in? # is this necessary
            @horse = Horse.find_by_slug(params[:slug])
            if @horse.user_id == current_user.id
                @horse.update(name: params[:name])

                redirect "/horses/#{@horse.slug}"
            else
                redirect "/access-error" # is this necessary
            end
        else
            redirect "/login"
        end
    end

    delete '/horses/:id' do
        horse = Horse.find(params[:id])
        if horse.user_id == current_user.id
            horse.destroy

            redirect "/users/#{current_user.slug}"
        else
            redirect "/access-error"
        end
    end
end