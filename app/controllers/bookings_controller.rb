class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @service = Service.find(params[:service_id])
    authorize @booking
  end

  def index
    @current_user_bookings = policy_scope(Booking.where(user: current_user))
    @none_rejected_bookings = current_user.bookings_as_owner.pending
    @other_bookings = current_user.bookings_as_owner do |booking|
      booking.status != "pending"
    end
    @pending_bookings = current_user.bookings.pending
    @review = Review.new
  end

  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @service = Service.find(params[:service_id])
    @booking.user = @user
    @booking.status = 1
    @booking.service = @service
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :user_id, :service_id, :start_date, :end_date)
  end
end
