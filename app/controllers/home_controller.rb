class HomeController < ApplicationController
    def index 
    end

    def search
      @resultados = Promotion.where('name = ?', params[:query])
    end
end
