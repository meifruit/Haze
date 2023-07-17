class ServicesController < ApplicationController
  skip_after_action :verify_authorized, only: :wishlist
  def index
    @user = current_user
    @services = policy_scope(Service)
    if params[:query].present?
      @services = Service.global_search(params[:query])
    else
      @services = Service.all
    end

    if params[:min_price].present? && params[:max_price].present?
      @services = @services.filter_by_price(params[:min_price].to_i, params[:max_price].to_i)
    end

    if @services.empty?
      flash.now[:notice] = "0 results"
    end
  end

  def show
    @service = Service.find(params[:id])
    @reviews = @service.reviews
    @review = Review.new
    @booking = Booking.new
    authorize @service
    @marker = [{
      lat: @service.user.geocode[0],
      lng: @service.user.geocode[1]
    }]
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    authorize @service
    if @service.save
      redirect_to service_path(@service)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    authorize @service
    @service.destroy
    redirect_to services_path
  end

  def toggle_favorite
    @service = Service.find_by(id: params[:id])
    authorize @service
    @user = current_user
    @user.favorited?(@service) ? @user.unfavorite(@service) : @user.favorite(@service)
    redirect_to services_path
  end

  def wishlist
    @service = Service.find_by(id: params[:id])
    @services = current_user.favorited_services
    @user = current_user
    render :wishlist
  end

private

  def service_params
    params.require(:service).permit(:price, :description, :title, :user_id, photos: [])
  end
end
