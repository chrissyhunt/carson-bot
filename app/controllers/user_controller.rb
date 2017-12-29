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
    if params[:user][:name] != "" && params[:user][:email] != "" && params[:user][:password] != "" && !User.find_by(email: params[:email][:password])
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

  post '/users/login' do
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect to '/users'
    else
      redirect to '/users/login'
    end
  end

  get '/users/edit' do
    if logged_in?
      @user = current_user
      erb :'/users/edit'
    else
      redirect to '/users/login'
    end
  end

  post '/users/edit' do
    if params[:user][:name] != "" && params[:user][:email] != "" && params[:user][:password] != ""
      @user = current_user
      @user.name = params[:user][:name]
      @user.email = params[:user][:email]
      @user.password = params[:user][:password]
      @user.save
      redirect to '/users'
    else
      redirect to '/users/edit'
    end
  end

  get '/users/logout' do
    session.clear
    redirect to '/users/login'
  end

end
