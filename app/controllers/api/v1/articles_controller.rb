module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Tous les articles sont chargées...', data: articles}, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Une article chargé les mecs ...', data: article}, status: :ok
      end

      def create
        article = Article.new(article_params)
        
        if article.save

          render json: {
            status: 'SUCCESS',
            message: "Article enregistée ! .....",
            data: article
          },status: :ok

        else
          render json: {
              status: 'ERROR',
              message: "L'article n'est pas enregistré....",
              data: article
          },status: :unprocessable_entity

        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: {
          status: 'SUCCESS',
          message: "L'article a bien été supprimée...",
          data: article
        }, status: :ok

      end

      def update

        article = Article.find(params[:id])
        if article.update_attributes(article_params)
          render json: {
            status: 'SUCCESS',
            message: "Article mises à jour ! .....",
            data: article
          },status: :ok
        else
          render json: {
            status: 'ERROR',
            message: "L'article n'est pas modifiée....",
            data: article
          },status: :unprocessable_entity

        end

      end

      private

      def article_params
        params.permit(:title, :body)
      end

    end
  end
end