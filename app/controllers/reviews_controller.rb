class ReviewsController < ApplicationController
  before_action :review

  def show
  end

  private

  def review
    @review ||= if params[:id]
        Review[params[:id]]
      else
        Review.new
      end
  end
end