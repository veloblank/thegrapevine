class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'users/signup'
    else
    redirect to :'/wines'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "You must enter all fields"
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/wines'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/wines'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to "/wines"
    else
      flash[:message] = "You must have an account to log in"
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have successfully logged out"
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
