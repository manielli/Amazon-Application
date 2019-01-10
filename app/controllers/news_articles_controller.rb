class NewsArticlesController < ApplicationController
    before_action :find_news_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :destroy]

    def new
        @news_article = NewsArticle.new
    end

    def create
        @news_article = NewsArticle.create news_article_params
        @news_article.user = current_user

        if @news_article.save
            redirect_to news_article_url(@news_article.id)
        else
            render :new
        end
    end
    
    def index
        @news_articles = NewsArticle.all.order(published_at: :desc)
    end

    def show
        # @news_article = NewsArticle.find params[:id]
    end
    
    def edit
        
    end
    
    def update
        if @news_article.update news_article_params
            redirect_to news_article_url(@news_article.id)
        else
            render :edit
        end
    end
    
    def destroy
        # news_article = NewsArticle.find params[:id]
        if can?(:delete, @news_article)
            @news_article.destroy
    
            redirect_to news_articles_url
        else
            flash[:danger] = "Access Denied"
            redirect_to news_article_url(@news_article.id)
        end
    end

    private
    def find_news_article
        @news_article = NewsArticle.find params[:id]
    end

    def news_article_params
        params.require(:news_article).permit(:title, :description)
    end
end
