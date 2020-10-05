class PrizesController < ApplicationController
    get '/prizes/new' do
        if logged_in?
            @user = current_user
        
            erb :"/prizes/new"        
        else
            redirect "/login"
        end
    end

    get '/prizes' do
        if logged_in?
            @user = current_user

            erb :"/prizes/index"
        else
            redirect "/login"
        end
    end

    post '/prizes' do
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
        if logged_in?
            @prize = Prize.find(params[:id])

            erb :"/prizes/show"
        else
            redirect "/login"
        end
    end

    get '/prizes/:id/edit' do
        if logged_in?
            @prize = Prize.find(params[:id])
            @user = current_user

            erb :"/prizes/edit"
        else
            redirect "/login"
        end
    end

    patch '/prizes/:id' do
        @user = current_user
        @prize = Prize.find(params[:id])

        if prize_valid?(params)
            @horseshow = Horseshow.find_or_create_by(params[:horseshow])
            @horse = Horse.find(params[:horse_id])
            @prize.update(point_total: params[:point_total], horseshow_id: @horseshow.id, horse_id: @horse.id, user_id: @user.id)

            redirect "/prizes"
        else
            "Prize input is invalid"
        end
    end

    delete '/prizes/:id' do
        if logged_in?
            prize = Prize.find(params[:id])
            prize.destroy

            redirect to "/prizes"
        else
            redirect "/login"
        end
    end
end