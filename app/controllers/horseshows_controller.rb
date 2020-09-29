class HorseshowsController < ApplicationController

    get '/horseshows' do
        erb :"/horseshows/index"
    end

    get '/horseshows/new' do 
        erb :"/horseshows/new"
    end

    get '/horseshows/:slug' do
        @horseshow = Horseshow.find_by_slug(params[:slug])

        erb :"/horseshows/show"
    end

    post '/horseshows' do
        @horseshow = Horseshow.find_or_create_by(name: params[:name])
        @horseshow.location = params[:location]
        @horseshow.save

        redirect to "/horseshows/#{@horseshow.slug}"
    end
end