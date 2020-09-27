class HorseShowsController < ApplicationController

    get '/horse-shows' do
        erb :"/horse-shows/index"
    end
end