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
        if !User.find_by(username: params[:username])
            @user = User.new(params)
            if @user.save #if params include username, name and password, @user can be persisted
                session[:user_id] = @user.id
                redirect to "/users/#{@user.slug}"
		    else
			    redirect "/signup_error" #include error message instead???
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