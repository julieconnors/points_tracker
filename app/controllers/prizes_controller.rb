class PrizesController < ApplicationController
    get '/prizes/new' do
        logged_out_redirection
        
        erb :"/prizes/new"        
    end

    get '/prizes' do
        logged_out_redirection

        erb :"/prizes/index"
    end

    post '/prizes' do
        binding.pry
        logged_out_redirection #is this necessary???
        if prize_valid?(params) #uses helper method to check is params are valid
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
            horseshow = Horseshow.find_or_create_by(params[:horseshow]) #finds or creates horseshow by params
        
            prize = Prize.create(point_total: params[:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: horse.user_id)
        
            redirect "/users/#{current_user.slug}"
        else
            redirect "/prizes/invalid-input"
        end
    end

    get '/prizes/:id' do
        logged_out_redirection
        @prize = Prize.find_by(id: params[:id])
        
        if @prize.user_id == current_user.id

            erb :"/prizes/show"
        else
            erb :"/access-error"
        end
    end

    get '/prizes/:id/edit' do
        logged_out_redirection
        @prize = Prize.find_by(id: params[:id])

        if @prize.user_id == current_user.id

            erb :"/prizes/edit"
        else
            erb :"/access-error"
        end
    end

    patch '/prizes/:id' do
        logged_out_redirection #is this necessary??
        prize = Prize.find_by(id: params[:id])

        if prize_valid?(params) #uses helper method to check if params data is valid
            horseshow = Horseshow.find_or_create_by(params[:horseshow])
            horse = Horse.find_by(id: params[:horse_id])
            prize.update(point_total: params[:point_total], horseshow_id: horseshow.id, horse_id: horse.id, user_id: current_user.id)

            redirect "/prizes/#{prize.id}"
        else
            redirect "/prizes/invalid-input"
        end
    end

    delete '/prizes/:id' do
        logged_out_redirection # is this necessary
        prize = Prize.find_by(id: params[:id])
        prize.destroy

        redirect to "/prizes"
    end

    helpers do
    
        def prize_valid?(params)
            return params[:horse_id] != nil && !params[:horseshow][:name].empty? && !params[:horseshow][:location].empty? && params[:point_total].to_i > 0
        end
    end
end