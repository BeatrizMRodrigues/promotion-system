class CouponsController < ApplicationController
  def show
    @coupon = Coupon.find(params[:id])
  end

  def disable
    @coupon = Coupon.find(params[:id])
    @coupon.disabled!
    redirect_to @coupon.promotion, notice: t('.success', code: @coupon.code)
  end

  def active
    @coupon = Coupon.find(params[:id])
    @coupon.active!
    redirect_to @coupon.promotion, notice: t('.success', code: @coupon.code)
  end

  def search
    @term = params[:query]
    @coupon = Coupon.search(@term)
  end
end
