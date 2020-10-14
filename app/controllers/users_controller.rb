class UsersController < ApplicationController
    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])

			erb :"/users/show"
		else
			redirect "/login"
		end    
    end

    get '/login' do
        erb :"/users/login"
    end

    post '/login' do
        @errors = {}
        if User.exists?(username: params[:username]) #checks if User can be found with params
            user = User.find_by(username: params[:username]) #finds user
            if user.authenticate(params[:password]) #checks if user can be authenticated with password provided
                session[:user_id] = user.id #logs user in by assigning session user_id

                redirect "/users/#{user.slug}"
            else
                @errors[:wrong_password] = "The password entered doesn't match our records."

                erb :"/users/login"
            end
        else
            @errors[:login] = "We were unable to find an account with the username provided."
            
            erb :"/users/login"
        end
    end
    
    get '/signup' do
        erb :"/users/signup"
    end

    post '/signup' do
        binding.pry
        if !User.find_by(username: params[:username]) #checks if there is already a user by this username
            user = User.new(params) #instantiates new user with params
            if user.save #this validates params input, if user can be persisted that means params includes username, password, and name
                session[:user_id] = user.id #logs new user in by assigning session user_id to new user
                
                redirect "/users/#{user.slug}"
            else
                @errors = error_generator(params) #creates a hash of error messages to be displayed in view 
                
                erb :"/users/signup"
            end
        else
            @errors = error_generator(params)

            erb :"/users/signup"
        end
    end

    get '/logout' do
        session.clear

        redirect '/'
    end

    helpers do
        def error_generator(params)
            errors = {}
            if User.exists?(username: params[:username])
                errors[:signup] = "The username you selected already exists."
            end
            if params[:name] == ""
                errors[:name] = "Please enter a name." 
            else
                @name = params[:name]
            end
            if params[:username] == ""
                errors[:username] = "Please enter a username."
            else
                @username = params[:username]
            end
            if params[:password] == ""
                errors[:password] = "Please enter a password."
            else
                @password = params[:password]
            end
            errors
        end
    end
end