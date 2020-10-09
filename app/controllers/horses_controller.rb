class HorsesController < ApplicationController

    get '/horses' do
        logged_out_redirection
            
        erb :"/horses/index"
    end

    get '/horses/new' do
        logged_out_redirection
        
        erb :"/horses/new"
    end

    get '/horses/:slug' do
        logged_out_redirection
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/show"
    end

    post '/horses' do
        logged_out_redirection #do I need login validation on post routes??
        
        horse = Horse.new(name: params[:name]) #instantiates new horse
        horse.user_id = current_user.id #assigns horse user_id to that of current_user
        if horse.save #saves horse with user_id set

            redirect "/horses/#{horse.slug}"
        else
            @error = "Either you already have a horse by that name or input is invalid."
            erb :"/horses/new"
        end
    end

    get '/horses/:slug/edit' do
        logged_out_redirection
            
        @horse = Horse.find_by_slug(params[:slug])

        erb :"/horses/edit" #render the edit page
    end

    patch '/horses/:slug' do
        logged_out_redirection # is this necessary

        @horse = Horse.find_by_slug(params[:slug])

        if @horse.update(name: params[:name]) #update horse with params data

            redirect "/horses/#{@horse.slug}"
        else
            @error = "Either you already have a horse by that name or input is invalid."

            erb :"/horses/edit"
        end
    end

    delete '/horses/:id' do
        logged_out_redirection #is this necessary??
        
        horse = Horse.find_by(id: params[:id]) #delete form sends id value through params
        
        horse.destroy

        redirect "/users/#{current_user.slug}"
    end
end