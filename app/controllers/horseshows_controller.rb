class HorseshowsController < ApplicationController

    get '/horseshows' do
        logged_out_redirection
        
        erb :"/horseshows/index"
    end

    get '/horseshows/:slug' do
        logged_out_redirection
        @horseshow = Horseshow.find_by_slug(params[:slug])

        erb :"/horseshows/show"
    end
end