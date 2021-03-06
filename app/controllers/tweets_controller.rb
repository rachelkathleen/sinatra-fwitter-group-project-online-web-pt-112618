class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find(session[:id])
      erb :'/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != "" && session[:id] != nil
      Tweet.create(content: params[:content], user_id: session[:id])
    else
      redirect '/tweets/new'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}/edit"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    if @tweet.user_id == session[:id]
      @tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end
end
