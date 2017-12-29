class LocationController < ApplicationController

  get '/locations' do
    if logged_in?
      @user = current_user
      @user_locations = current_user.locations.uniq
      erb :'/locations/index'
    else
      redirect to '/users/login'
    end
  end

  get '/locations/:id' do
    @location = Location.find_by(id: params[:id])
    @user_items = current_user.items
    if logged_in? && current_user.locations.include?(@location)
      erb :'locations/show'
    else
      redirect to '/users/login'
    end
  end

  get '/locations/:id/edit' do
    @location = Location.find_by(id: params[:id])
    if logged_in? && current_user.locations.include?(@location)
      erb :'locations/edit'
    else
      redirect to '/users/login'
    end
  end

  post '/locations/:id/edit' do
    location = Location.find_by(id: params[:id])
    if !location.admin_lock
      location.name = params[:name]
      location.save
      redirect to "/locations/#{location.id}"
    else
      redirect to '/locations'
    end
  end


end
