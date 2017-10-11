class ArticlesController < ApplicationController 
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new 
    @article = Article.new
  end 
  def create 
    # debugger
    @article = Article.new(articles_params)
    @article.user = User.find(6)
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update 
    if @article.update(articles_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      render edit
    end
  end

  def show 
  end
  
  def destroy 
    @article.destroy
    flash[:danger] = "Article was successfully Destroyed"
    redirect_to articles_path
  end
  
  private 
  def set_article
    @article = Article.find(params[:id])
    
  end
  def articles_params 
    params.require(:article).permit(:title,:description)
  end
end
