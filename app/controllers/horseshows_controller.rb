class HorseshowsController < ApplicationController

    get '/horseshows' do
        logged_out_redirection
        
        erb :"/horseshows/index"
    end

    get '/horseshows/:id' do
        logged_out_redirection
        @horseshow = Horseshow.find_by(id: params[:id])

        erb :"/horseshows/show"
    end
end