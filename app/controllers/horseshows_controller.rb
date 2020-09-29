class HorseshowsController < ApplicationController

    get '/horseshows' do
        erb :"/horseshows/index"
    end

    get '/horseshows/:slug' do
        @horseshow = Horseshow.find_by_slug(params[:slug])

        erb :"/horseshows/show"
    end

    post '/horseshows' do
        binding.pry
        #@horseshow = Horseshow.find_or_create_by(name:)

        redirect to "/horseshows/#{@horseshow.slug}"
    end
end