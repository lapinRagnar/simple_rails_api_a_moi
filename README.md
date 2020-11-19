# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Les etapes

- créer l'appication
-------------------------------

rails new nom_api --api 

- configurer la base de données
----------------------------------------------------------
  ... et rails db:create
  
- créer un model
------------------------------------------------------------
  rails g model Article title:string body:text

  dans le model ajouter:
  validates :title, presence: true
  calidates :body, presence: true
- ajouter des données dans le model
-------------------------------------------------------------------------------------
  
  gem install faker
  ou 
  dans gemfile, ajouter: 
  gem 'faker'

  ensuite, dans seed.rb, ajouter:

  5.times do
      Article.create({
        title: Faker::Book.title,
        body: Faker::Lorem.sentence
    })
  end

  puis faire: rails db:seed

  - creer un fichier (et dossier) app/controllers/api/v1/article_controller.rb
  -----------------------------------------------------------------------------------------------------------------

  module Api
    module V1
      class ArticlesController < ApplicationController
        def index
          article = Article.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Article chargé', data: article}, status: :ok
        end

      end
    end
  end

- dans routes.rb
--------------------------------------------------------------------------------------------------------------------------
Rails.application.routes.draw do
  
  namespace 'api' do
    namespace 'v1' do
      resources :articles    
    end
  end

end

    
- installer le plugin postman chrome
----------------------------------------------------------------------------------------------------------

 => faire un requete Get dans : localhost/api/v1/articles

- faire le CRUD entier, en changeant app/controllers/api/v1/article_controller.rb comme suit:
------------------------------------------------------------------------------------------------------

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

      private

      def article_params
        params.permit(:title, :body)
      end

    end
  end
end

- verifier dans postman:
---------------------------------
  => on choisit POST
  => taper http://localhost:8080/api/v1/articles
  => dans headers -> choisir dans key : content-type (dans la barre de recherche) et dans value on met appication/json
    et 
  => dans body, selectionner raw, et ajouter dedans : (ce qu'on veut ajouter dans notre article)
    {
        "title":" ceci est un titre poster avec postman",
        "body":" c'est un body que j'ai fait avec postman les mecs....."
    }
  => pour la suppression, ajouter à la fin de app/controllers/api/v1/article_controller.rb comme suit:

    def destroy
      article = Article.find(params[:id])
      article.destroy
      render json: {
        status: 'SUCCESS',
        message: "L'article a bien été supprimée...",
        data: article
      }, status: :ok

    end
  
  => et dans postman, on fait:
    * selectionner DELETE
    * taper l'url http://localhost:8080/api/v1/articles/8

  => la mise à jour d'un article: dc dans app/controllers/api/v1/article_controller.rb , on ajoute:

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

  => et dans postman, on verifier:
    * choisir UPDATE et headears content-type et value application/json, body raw et on ajoute dans body:
      {
          "title": "titre mise a jour",
          "body": "contenu mise a jour"

      }

ET voila Merci!







