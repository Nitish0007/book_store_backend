class BooksController < ApplicationController
    before_action :authenticate_request, except: [:index, :show]
    
    before_action :book_params, only: :create
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
            render json: {message: @book.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        render json: @book, status: :ok
    end

    def update

    end

    def destroy
        if @book.destroy
            render json: {message: 'book deleted from the database'}, status: :ok
        end
    end

    def add_to_cart
        book = Book.find(params[:book_id])
        order = Order.new({book_id: book.id, book_name: book.name, price: book.price, quantity: 1, total: book.price, placed: false, user_id: @current_user.id})
        order.cart = @current_user.cart
        if order.save
            render json: {order: order, message: 'order created'}, status: :ok
        else
            render json: {message: order.errors.full_messages}, status: :unprocessable_entity
        end
    end

    


    protected
    def book_params
        params.require(:book).permit(:name, :author, :price)
    end

    def set_book
        @book = Book.find(params[:id])
    end

end
