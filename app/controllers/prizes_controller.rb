class PrizesController < ApplicationController
    
    @errors = {}

    get '/prizes' do
        logged_out_redirection
        
        erb :"/prizes/index"
    end
    
    get '/prizes/new' do
        logged_out_redirection
        
        erb :"/prizes/new"        
    end

    post '/prizes' do
        logged_out_redirection #is this necessary???
        if horse_valid?(params) && prize_valid?(params) && show_exist?(params) && !new_show_input_entered?(params)#if these conditions are met, a horse and horseshow can be found & prize can be created and there is no new horse show input
            horseshow = Horseshow.find_by(id: params[:horseshow_id]) #finds horseshow by id in params
                
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
            if Prize.where("horse_id = ? AND horseshow_id =?", horse.id, horseshow.id).empty?#check if a prize already exists for that horse and horseshow
                @prize = Prize.create(point_total: params[:prize][:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: current_user.id)
        
                redirect "/prizes/#{@prize.id}"
            else
                @errors[:duplicate_prize] = "This is a duplicate prize. You can edit an existing prize or add a new prize."

                erb :"/prizes/new"
            end
        elsif horse_valid?(params) && prize_valid?(params) && !show_exist?(params) && show_input_valid?(params)#if these conditions are met a horse can be found & a show and a prize van be created
            horseshow = Horseshow.create(params[:horseshow])
            
            horse = Horse.find_by(id: params[:horse_id])
            
            @prize.create(point_total: params[:prize][:point_total], horseshow_id: horseshow.id, horse_id: horse.id, user_id: current_user.id)

            redirect "/prizes/#{@prize.id}"
        elsif horse_valid?(params) && prize_valid?(params) && show_exist?(params) && new_show_input_entered?(params)#checks if existing horse show and new horse show input are added 
            @horse = Horse.find_by(id: params[:horse_id])
            @horseshow = Horseshow.find_by(id: params[:horseshow_id])
            @errors[:duplicate_show_input] = "Please either select an existing horse show or add a new horse show."

            erb :"/prizes/new"

        elsif !horse_valid?(params) || !prize_valid?(params) || !show_input_valid?(params) #if we cannot find or create a horseshow, we cannot create a prize
            @errors = error_generator(params) #creates hash of error messages to use in view

            erb :"/prizes/new"
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
        logged_out_redirection
        @prize = Prize.find_by(id: params[:id])

        if horse_valid?(params) && prize_valid?(params) && show_exist?(params) && !new_show_input_entered?(params)#if these conditions are met, a horse and horseshow can be found & prize can be created
            horseshow = Horseshow.find_by(id: params[:horseshow_id]) #finds horseshow by id in params
                
            horse = Horse.find_by(id: params[:horse_id]) #finds horse by horse_id in params
            if Prize.where("horse_id = ? AND horseshow_id = ? AND point_total = ?", horse.id, horseshow.id, params[:prize][:point_total]).empty?#check if a prize already exists for that horse and horseshow
                
                @prize.update(point_total: params[:prize][:point_total], horse_id: horse.id, horseshow_id: horseshow.id, user_id: current_user.id)
        
                redirect "/prizes/#{@prize.id}"
            else
                @errors[:duplicate_prize] = "This is a duplicate prize. You can edit an existing prize or add a new prize."

                erb :"/prizes/edit"
            end

        elsif horse_valid?(params) && prize_valid?(params) && !show_exist?(params) && show_input_valid?(params)#if these conditions are met a horse can be found & a show and a prize van be created
            horseshow = Horseshow.create(params[:horseshow])
            
            horse = Horse.find_by(id: params[:horse_id])
            
            @prize.update(point_total: params[:prize][:point_total], horseshow_id: horseshow.id, horse_id: horse.id, user_id: current_user.id)

            redirect "/prizes/#{@prize.id}"
        elsif horse_valid?(params) && prize_valid?(params) && show_exist?(params) && new_show_input_entered?(params) 
            @errors[:duplicate_show_input] = "Please either select an existing horse show or add a new horse show."

            erb :"/prizes/edit"

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
             Prize.create(params[:prize]).valid?
        end

        def horse_valid?(params)
            params[:horse_id] != nil
        end

        def show_exist?(params)
            !!params[:horseshow_id]
        end

        def new_show_input_entered?(params)
            !params[:horseshow].values.all?{|value| value == ""}
        end

        def show_input_valid?(params)
            Horseshow.create(params[:horseshow]).valid?
        end

        def error_generator(params)
            errors = {}
            if params[:horse_id] == nil
                errors[:horse] = "Please select or add a horse" 
            end
            if !!prize_valid? #params[:prize][:point_total].to_i <= 0
                errors[:points] = "Please enter integer point value."
            end
            if params[:horseshow_id] == nil
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