class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    # params is a hash with the key :id
    @article = Article.find(params[:id])
  end
end
