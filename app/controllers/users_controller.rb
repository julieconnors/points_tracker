class UsersController < ApplicationController

    get '/login' do
        erb :"/users/login"
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])

			erb :"/users/show"
		else
			redirect "/login"
		end    
    end

    post '/users' do
        #do I need login validation on post routes??
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            redirect to "/users/#{@user.slug}"
        else
            redirect "/login_error"
        end
    end
    
    get '/signup' do
        
        erb :"/users/signup"
    end

    post '/signup' do
        if !User.find_by(username: params[:username]) #checks if there is a user by this username
            user = User.new(params) #instantiates new user
            if user.save #this validates params input, if user can be persisted, params includes username, password, and name
                session[:user_id] = user.id #logs user in by assign session user_id to new user
                redirect to "/users/#{user.slug}"
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