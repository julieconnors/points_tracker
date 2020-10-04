class HorseshowsController < ApplicationController

    get '/horseshows' do
        if logged_in?
            erb :"/horseshows/index"
        else
          redirect "/login"  
        end
    end

    get '/horseshows/:slug' do
        if logged_in?
            @horseshow = Horseshow.find_by_slug(params[:slug])

            erb :"/horseshows/show"
        else
            redirect "/login"
        end
    end
end