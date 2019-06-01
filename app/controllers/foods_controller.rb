class FoodsController < ApplicationController
  include FoodsHelper

  def index
    search_rakuten_api(params[:keyword]) if params[:keyword].present?
  end

  def search_rakuten_api(keyword)
    if two_or_more_characters?(keyword)
      flash[:danger] = "2文字以上で検索してください"
      redirect_back(fallback_location: root_path)
    end

    @items = RakutenWebService::Ichiba::Item.search(keyword: keyword)
  end
end
