class UserController < ApplicationController

  get '/users' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    erb :'/users/show'
  end

  get '/users/signup' do
    if logged_in?
      redirect to '/users'
    end

    erb :'/users/create'
  end

  post '/users/signup' do
    if params[:user][:name] == "" || params[:user][:name] == " " || params[:user][:name].blank?
      flash[:message] = "You must provide a name."
      redirect to '/users/signup'
    end

    if params[:user][:email] == "" || params[:user][:email] == " " || params[:user][:email].blank?
      flash[:message] = "You must provide a valid email address."
      redirect to '/users/signup'
    end

    if params[:user][:password] == "" || params[:user][:password] == " " || params[:user][:password].blank?
      flash[:message] = "You must select a password."
      redirect to '/users/signup'
    end

    if User.find_by(email: params[:user][:email])
      flash[:message] = "An account already exists for that email address.<br> Please log in or choose a different email."
        redirect to '/users/signup'
      end

      new_user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])

      if new_user.save
        session[:user_id] = new_user.id
        redirect to '/users'
      else
        redirect to '/signup'
      end
    end

  get '/users/login' do
    if logged_in?
      redirect to '/users'
    end

    erb :'/users/login'
  end

  post '/users/login' do
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect to '/users'
    else
      flash[:message] = "I'm sorry, that's not the right password. Please try again."
      redirect to '/users/login'
    end
  end

  get '/users/edit' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    erb :'/users/edit'
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
      flash[:message] = "You must provide a name, email address, and password."
      redirect to '/users/edit'
    end
  end

  get '/users/logout' do
    session.clear
    redirect to '/users/login'
  end

  delete '/users/delete' do
    if !logged_in?
      redirect to '/users/login'
    end

    current_user.delete
    session.clear
    redirect to '/'
  end

end
