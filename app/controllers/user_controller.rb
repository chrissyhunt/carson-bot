class UserController < ApplicationController

  get '/users' do
    if logged_in?
      @user = current_user
      erb :'/users/index'
    else
      redirect to '/users/login'
    end
  end

  get '/users/signup' do
    erb :'/users/create'
  end

  post '/users/signup' do
    if params[:user][:name] != "" && params[:user][:email] != "" && params[:user][:password] != "" &&
      new_user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
      if new_user.save
        session[:user_id] = new_user.id
        redirect to '/users'
      else
        redirect to '/signup'
      end
    else
      redirect to '/signup'
    end
  end

  get '/users/login' do
    erb :'/users/login'
  end

  get '/users/edit' do
    @user = current_user
    erb :'/users/edit'
  end

end
