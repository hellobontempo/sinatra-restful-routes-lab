class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #DISPLAY ALL 
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #CREATE & SAVE
  get '/recipes/new' do
    erb :new
  end
  
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  #DISPLAY SINGLE
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #EDIT/PATCH RECIPE

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  #DELETE RECIPE

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    redirect '/recipes'
  end

end 
