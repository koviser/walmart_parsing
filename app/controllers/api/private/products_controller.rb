class Api::Private::ProductsController < ApplicationController
  def index
    render json: ProductDatatable.new(view_context, Product.all)
  end

  def create
    if product.save
      ParserProductWorker.perform_async(product.id)
      render json: 'Url added in order'
    else
      render json: product.errors.values, status: 400
    end
  end

  def reviews
    render json: ReviewDatatable.new(view_context, product.reviews)
  end

  private

  def product
    @product ||= if params[:product_id]
        Product[params[:product_id]]
      else
        Product.new(product_params)
      end
  end

  def product_params
    params.permit(:url)
  end
end