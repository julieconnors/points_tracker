class UsersController < ApplicationController

    get '/login' do
        erb :"/users/login"
    end

    get '/account' do
        if Helper.is_logged_in?(session)
			erb :"/users/home"
		else
			redirect "/login"
		end    
    end

    post '/login' do
        @user = User.all.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            redirect to "/account"
        else
            erb :"/users/error"
        end
    end
    
    get '/signup' do
        
        erb :"/users/signup"
    end

    post '/signup' do
        if !User.all.find_by(username: params[:username])
            @user = User.new(params)
            if @user.save #if params include username and password, @user can be persisted
                session[:user_id] = @user.id
                redirect to "/account"
		    else
			    redirect "/users/error"
            end
        else
            erb :"users/signup_error"
        end
    end

    get '/logout' do
        session.clear

        redirect to '/'
    end

    get '/error' do
        erb :error
    end
end