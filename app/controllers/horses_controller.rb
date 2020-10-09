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

        if current_user.id == @horse.user_id

            erb :"/horses/show"
        else
            erb :"/access-error"
        end
    end

    post '/horses' do
        binding.pry
        logged_out_redirection #do I need login validation on post routes??
        if horse_valid?
                horse = Horse.new(name: params[:name]) #instantiates new horse
                horse.user_id = current_user.id #assigns horse user_id to that of current_user
                horse.save #saves horse with user_id set

                flash[:message] = "Created horse"
                redirect "/horses/#{horse.slug}"
        else
            flash[:error] = "Please enter valid input"
            redirect "/horses/new"
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

        horse = Horse.find_by_slug(params[:slug])

        if horse.user_id == current_user.id #if horse belongs to current_user
            #if horse_valid?
            if horse.update!(name: params[:name]) #update horse with params data

                redirect "/horses/#{horse.slug}"
            else
                redirect "/horses/invalid-input"
            end
        else
            redirect "/access-error" # is this necessary
        end
    end

    delete '/horses/:id' do
        logged_out_redirection #is this necessary??
        
        horse = Horse.find_by(id: params[:id]) #delete form sends id value through params
        
        if horse.user_id == current_user.id
            horse.destroy

            redirect "/users/#{current_user.slug}"
        else
            redirect "/access-error"
        end
    end

    helpers do
        def horse_valid? #checks that name field is not an empty string and there is not already a horse by the name provided
            params[:name] != "" && !Horse.find_by(name: params[:name].capitalize)
        end  
    end
end