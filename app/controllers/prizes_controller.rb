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

    get '/prizes/duplicate' do
        erb :"/prizes/duplicate"
    end

    post '/prizes' do
        binding.pry
        logged_out_redirection #is this necessary???
        if params[:horseshow][:id] != nil && prize_valid?(params) #checks if params includes horseshow id (meaning the horseshow exists) and if prize input is valid
            horseshow = Horseshow.find_by(id: params[:horseshow][:id]) #finds horseshow by id in params
                
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
            if !Prize.where("horse_id = ? AND horseshow_id =?", horse.id, horseshow.id)#check if a prize already exists for that horse and horseshow
                prize = Prize.create(point_total: params[:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: horse.user_id)
        
                redirect "/users/#{current_user.slug}"
            else
                redirect "/prizes/duplicate"
            end
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
        @errors = {}

        if @prize.user_id == current_user.id

            erb :"/prizes/edit"
        else
            erb :"/access-error"
        end
    end

    patch '/prizes/:id' do
        binding.pry
        logged_out_redirection
        @prize = Prize.find_by(id: params[:id])

        if horse_valid?(params) && prize_valid?(params) && show_exist?(params)#if these conditions are met, a horse and horseshow can be found & prize can be created
            horseshow = Horseshow.find_by(id: params[:horseshow][:id]) #finds horseshow by id in params
                
            horse = Horse.find_by(id: params[:horse][:id]) #finds horse by horse_id in params
            if !Prize.where("horse_id = ? AND horseshow_id =?", horse.id, horseshow.id)#check if a prize already exists for that horse and horseshow
                prize = Prize.update(point_total: params[:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: horse.user_id)
        
                redirect "/prizes/#{prize.id}"
            else
                @error = "This is a duplicate prize. You can edit an existing prize or add a new prize."

                erb :"/prizes/edit"
            end

        elsif horse_valid?(params) && prize_valid?(params) && !show_exist?(params) && show_input_valid?(params) #if these conditions are met a horse can be found & a show and a prize van be created
            horseshow = Horseshow.create(params[:horseshow])
            
            horse = Horse.find_by(id: params[:horse_id])
            
            prize.update(point_total: params[:point_total], horseshow_id: horseshow.id, horse_id: horse.id, user_id: current_user.id)

            redirect "/prizes/#{prize.id}"
        elsif !horse_valid?(params) || !prize_valid?(params) || !show_input_valid?(params) #if we cannot find or create a horseshow, we cannot create a prize
            @errors = error_generator(params) #creates hash of error messages to use in view

            erb :"/prizes/edit"
        end
    end

    delete '/prizes/:id' do
        logged_out_redirection
        prize = Prize.find_by(id: params[:id])
        prize.destroy

        redirect to "/prizes"
    end

    helpers do
    
        def prize_valid?(params)
             params[:point_total].to_i > 0
        end

        def horse_valid?(params)
            params[:horse_id] != nil
        end

        def show_exist?(params)
            !!params[:horseshow][:id]
        end

        def show_input_valid?(params)
            Horseshow.create(params[:horseshow]).valid?
            #params[:horseshow][:date] != "" && !params[:horseshow][:name].empty? && !params[:horseshow][:location].empty?
        end

        def error_generator(params)
            errors = {}
            if params[:horse_id] == nil
                errors[:horse] = "Please select or add a horse" 
            end
            if params[:point_total].to_i <= 0
                errors[:points] = "Please enter integer point value."
            end
            if params[:horseshow][:id] == nil
                if params[:horseshow][:name] == ""
                    errors[:horseshow_name] = "Please enter a horse show name"
                end
                if params[:horseshow][:location] == ""
                    errors[:location] = "Please provide a location"
                end
                if params[:horseshow][:date] == ""
                    errors[:date] = "Please select a date"
                end
            end
            errors
        end
    end
end