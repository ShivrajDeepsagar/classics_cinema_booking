class UsersController < ApplicationController

  include SessionsHelper
  before_action :logged_in_user, only: [:user, :booking]


  def show
    user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(user)
  end

  def new
    if logged_in?
      flash[:danger] = 'you already have active session.Please logout to create new account'
      redirect_to root_path
    else
      user = User.new
      @errors = []
    end
  end

  def create
    user = User.new(user_params)   
    if user.save
      log_in user
      flash[:success] = "Welcome to the Movie Booking!"
      redirect_to root_path
    else
      @errors = user.errors.full_messages
      render 'new'
    end
  end
  
  def booking
    @reservations = Reservation.where(user_id: current_user.id).order("created_at desc")
  end

  def cancle_ticket
    reservation_id = params[:booking]["reservation_id"].to_i
    reservation = Reservation.find(reservation_id)

    show_num = reservation.show_num
    number_of_seats = reservation.seat.seat_details.length
    
    screening_info = reservation.screening
    if show_num == 1
      screening_info.first_seats = reservation.screening.first_seats + number_of_seats
    elsif show_num == 2
      screening_info.second_seats = reservation.screening.second_seats + number_of_seats
    elsif show_num == 3
      screening_info.third_seats = reservation.screening.third_seats + number_of_seats
    elsif show_num == 4
      screening_info.fourth_seats = reservation.screening.fourth_seats + number_of_seats
    end
    screening_info.save

    reservation.seat.destroy
    Transactions.where(reservation_id: reservation_id).first.destroy

    if reservation.destroy
      flash[:success] = "successfully deleted"
    end
    redirect_to :back
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
