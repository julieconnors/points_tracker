class HorseshowsController < ApplicationController

    get '/horseshows' do
        erb :"/horseshows/index"
    end

    get '/horseshows/:slug' do
        @horseshow = Horseshow.find_by_slug(params[:slug])

        erb :"/horseshows/show"
    end

    post '/horseshows' do
        @horseshow = Horseshow.find_by(name: params[:name])

        redirect to "/horseshows/#{@horseshow.slug}"
    end
end