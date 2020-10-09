class HorsesController < ApplicationController

    get '/horses' do
        logged_out_redirection
            
        erb :"/horses/index"
    end

    get '/horses/new' do
        logged_out_redirection
        
        erb :"/horses/new"
    end

    get '/horses/invalid-input' do
        erb :"/horses/invalid-input"
    end
    
    get '/horses/duplicate' do
        erb :"/horses/duplicate-error"
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
            @error = "Horse name should contain only letters and numbers"
            erb :"/horses/new"
            #redirect "/horses/invalid-input"
        end
    end

    get '/horses/:slug/edit' do
        logged_out_redirection
            
        @horse = Horse.find_by_slug(params[:slug])

        if @horse.user_id == current_user.id #if horse belongs to current user
            erb :"/horses/edit" #render the edit page
        else
            erb :"/access-error"
        end
    end

    patch '/horses/:slug' do
        logged_out_redirection # is this necessary

        @horse = Horse.find_by_slug(params[:slug])

        if @horse.update(name: params[:name]) #update horse with params data

            redirect "/horses/#{@horse.slug}"
        else
            @error = "Horse name should contain only letters and numbers"

            erb :"/horses/edit"
        end
    end

    delete '/horses/:id' do
        logged_out_redirection #is this necessary??
        
        horse = Horse.find_by(id: params[:id]) #delete form sends id value through params
        
        horse.destroy

        redirect "/users/#{current_user.slug}"
    end

    helpers do
        def horse_valid? #checks that name field is not an empty string and there is not already a horse by the name provided
            params[:name] != "" && !Horse.find_by(name: params[:name].capitalize)
        end  
    end
end