class UsersController < ApplicationController

    get '/login' do
        erb :"/users/login"
    end

    get '/user/:id' do #change to username slug???
        if logged_in?
        @user = User.find_by(id: session[:user_id])
			erb :"/users/show"
		else
			redirect "/login"
		end    
    end

    post '/users' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            redirect to "/user/#{@user.id}" #change to usersname slug???
        else
            redirect "/login_error"
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
                redirect to "/users/#{@user.id}"
		    else
			    redirect "/signup_error" 
            end
        else
            redirect "/signup_error"
        end
    end

    get '/logout' do
        session.clear

        redirect to '/'
    end

    get '/login_error' do
        erb :"/users/login_error"
    end

    get '/signup_error' do
        erb :"/users/signup_error"
    end
end