class PrizesController < ApplicationController
    get '/prizes/new' do
        logged_out_redirection
        
        erb :"/prizes/new"        
    end

    get '/prizes' do
        logged_out_redirection

        erb :"/prizes/index"
    end

    get '/prizes/invalid' do
        erb :"/prizes/invalid-input"
    end

    post '/prizes' do
        logged_out_redirection #is this necessary???
        if params[:horseshow][:id] != nil && prize_valid?(params) #checks if params includes horseshow id (meaning the horseshow exists) and if prize input is valid
            horseshow = Horseshow.find_by(id: params[:horseshow][:id]) #finds horseshow by id in params
                
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
        
            prize = Prize.create(point_total: params[:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: horse.user_id)
        
            redirect "/users/#{current_user.slug}"
        elsif params[:horseshow][:id] == nil && prize_valid?(params) && show_input_valid?(params) #checks if horse show does not exist, if prize input is valid and if horseshow input is valid
            horseshow = Horseshow.create(params[:horseshow]) #creates horseshow by params
            
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
            
            prize = Prize.create(point_total: params[:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: horse.user_id)

            redirect "/users/#{current_user.slug}"
        else
            redirect "/prizes/invalid"
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
            redirect "/prizes/invalid"
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
            params[:horse_id] != nil && params[:point_total].to_i > 0
        end

        def show_input_valid?(params)
            params[:horseshow][:date] != "" && !params[:horseshow][:name].empty? && !params[:horseshow][:location].empty?
        end
    end
end