class ProductsController < ApplicationController
  before_action :product

  def index
  end


  def show
  end

  private

  def product
    @product ||= if params[:id]
        Product[params[:id]]
      else
        Product.new
      end
  end
end