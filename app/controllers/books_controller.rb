class BooksController < ApplicationController
    before_action :authenticate_request, except: [:index, :show]
    before_action :book_params, only: [:create, :update]
    before_action :set_book, only: [:show, :destroy, :update]
    before_action :set_order, only: [:update_order, :delete_order]

    def index
        @books = Book.all
        render json: @books, status: :ok
    end

    def create
        if @current_user.is_admin == true
            @book = Book.new(book_params)
            if @book.save
                render json: @book, status: :ok
            else
                render json: {message: @book.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {message: "User do not have admin rights"}, status: :unauthorized
        end
    end

    def show
        render json: @book, status: :ok
    end

    def update
        if @current_user.is_admin == true
            if @book.update!(book_params)
                render json: {book: @book, message: 'book updated successfully'}, status: :ok
            end
        else
            render json: {message: "User do not have admin rights"}, status: :unauthorized
        end
    end

    def destroy
        if @current_user.is_admin == true
            if @book.destroy
                render json: {message: 'book deleted from the database'}, status: :ok
            end
        else
            render json: {message: "User do not have admin rights"}, status: :unauthorized
        end
    end


    def update_order
        if params[:quantity] == 0
            delete_order
        else
            quantity = params[:quantity]
            total = @order.price * params[:quantity]
            if @order.update!(total: total, quantity: quantity)
                render json: {order: @order, message: 'order updated'}, status: :ok
            else
                render json: {message: @order.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end
    
    def delete_order
        if @order.destroy
            render json: {message: 'order removed from cart'}
        end
    end

    def add_to_cart
        user_orders = Order.where(user_id: @current_user.id, book_id: params[:book_id], placed: false)
        prev_order = user_orders.find_by(book_id: params[:book_id]) if !user_orders.empty?

        if prev_order
            quantity = prev_order[:quantity] + 1;
            total = prev_order[:price] + prev_order[:total]
            prev_order.update!(total: total, quantity: quantity)
            render json: {order: prev_order, message: 'successfully added to cart'}, status: :ok
        else
            book = Book.find(params[:book_id])
            order = Order.new({book_id: book.id, book_name: book.name, price: book.price, quantity: 1, total: book.price, placed: false, user_id: @current_user.id})
            if order.save
                render json: {order: order, message: 'order created'}, status: :ok
            else
                render json: {message: order.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end

    


    protected
    def book_params
        params.require(:book).permit(:name, :author, :price)
    end

    def set_book
        @book = Book.find(params[:id])
    end

    def set_order
        @order = Order.find(params[:order_id])
    end


end
