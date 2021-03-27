class HomeController < ApplicationController
    def index 
    end

    def search
      @promotions = Promotion.where('name = ?', params[:query])
    end
end
