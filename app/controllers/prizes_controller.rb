class PrizesController < ApplicationController
    get '/prizes/new' do
        logged_out_redirection
        @user = current_user
        
        erb :"/prizes/new"        
    end

    get '/prizes' do
        logged_out_redirection
        @user = current_user

        erb :"/prizes/index"
    end

    post '/prizes' do
        logged_out_redirection #is this necessary???
        @user = current_user
        #do I need login validation for post routes??
        if prize_valid?(params)
            @horse = Horse.find(params[:horse_id])
            @horseshow = Horseshow.find_or_create_by(params[:horseshow])
        
            @prize = Prize.create(point_total: params[:point_total], horse_id: @horse.id, horseshow_id: @horseshow.id, user_id: @horse.user_id)
        
            redirect "/users/#{@user.slug}"
        else
            "Prize input is invalid" #link to an error page??
        end
    end

    get '/prizes/:id' do
        logged_out_redirection
        @prize = Prize.find(params[:id]) #add find_prize helper method??
        
        if @prize.user_id == current_user.id

        erb :"/prizes/show"
        else
            erb :"/prizes/access-error"
        end
    end

    get '/prizes/:id/edit' do
        logged_out_redirection
        @prize = Prize.find(params[:id]) #add find prize helper method??
        @user = current_user

        erb :"/prizes/edit"
    end

    patch '/prizes/:id' do
        logged_out_redirection #is this necessary??
        @user = current_user
        @prize = Prize.find(params[:id]) #add find_prize helper method??

        if prize_valid?(params)
            @horseshow = Horseshow.find_or_create_by(params[:horseshow])
            @horse = Horse.find(params[:horse_id])
            @prize.update(point_total: params[:point_total], horseshow_id: @horseshow.id, horse_id: @horse.id, user_id: @user.id)

            redirect "/prizes/#{@prize.id}"
        else
            "Prize input is invalid"
        end
    end

    delete '/prizes/:id' do
        logged_out_redirection # is this necessary
        prize = Prize.find(params[:id]) #add find_prize helper method??
        prize.destroy

        redirect to "/prizes"
    end

    helpers do
    
        def prize_valid?(params)
            return params[:horse_id] != nil && !params[:horseshow][:name].empty? && !params[:horseshow][:location].empty? && params[:point_total].to_i > 0
        end
    end
end