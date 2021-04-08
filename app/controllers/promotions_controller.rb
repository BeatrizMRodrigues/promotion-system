class PromotionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_promotion, only: %i[show generate_coupons edit update destroy approve]
  before_action :can_be_approved, only: [:approve]

  def index
    @promotions = Promotion.all
  end

  def show; end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = current_user.promotions.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def edit; end

  def update
    @promotion.update(promotion_params)
    redirect_to @promotion
  end

  def destroy
    @promotion.destroy
    redirect_to root_path
  end

  def generate_coupons
    @promotion.generate_coupons!
    redirect_to @promotion, notice: t('.success')
  end

  def search
    @term = params[:query]
    @promotions = Promotion.search(@term)
  end

  def approve
    current_user.promotion_approvals.create!(promotion: @promotion)
    PromotionMailer
      .with(promotion: @promotion, approver: current_user)
      .approval_email
      .deliver_now
    redirect_to @promotion, notice: 'Promoção aprovada com sucesso'
  end
  
  private

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :expiration_date, :description,
              :discount_rate, :code, :coupon_quantity)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def authenticate_user
    redirect_to '/login' unless user_signed_in?
  end

  def can_be_approved
    unless @promotion.can_approve?(current_user)
      redirect_to @promotion,
                  alert: t('.success')
    end
  end
end
