class LocationController < ApplicationController

  get '/locations' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    @user_locations = current_user.locations.uniq.sort_by {|location| location.name}
    erb :'/locations/index'
  end

  get '/locations/:id' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    @location = Location.find_by(id: params[:id])
    @user_items = current_user.items.sort_by {|item| item.name}
    @location_items = @location.items.select {|item| item.user == current_user}
    @location_categories = @location_items.map {|item| item.category.name}

    if current_user.locations.include?(@location)
      erb :'locations/show'
    else
      redirect to '/locations'
    end
  end

  get '/locations/:id/edit' do
    if !logged_in?
      redirect to '/users/login'
    end

    @location = Location.find_by(id: params[:id])

    if current_user.locations.include?(@location)
      erb :'locations/edit'
    else
      redirect to '/locations'
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
