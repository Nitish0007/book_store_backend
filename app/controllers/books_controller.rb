class BooksController < ApplicationController
    # before_action :authenticate_request, except: [:index, :show]
    
    before_action :book_params
    before_action :set_book, only: [:show, :destroy, :update]

    def index
        @books = Book.all
        render json: @books, status: :ok
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            render json: @book, status: :ok
        else
            rendor json: {message: 'unable to store'}, status: :unprocessable_entity
        end
    end

    def show
        render json: @book, status: :ok
    end

    def update

    end

    def destroy

    end


    protected
    def book_params
        params.permit(:name, :author, :price, :order_id)
    end

    def set_book
        @book = Book.find(params[:id])
    end

end
