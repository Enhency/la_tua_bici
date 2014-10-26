module WorkshopsApi
  class API < Grape::API
    format :json
    content_type :json, 'application/json; charset=utf-8'

    get do
      WorkShop.all
    end

    get ":id" do
      WorkShop.find(params[:id])
    end

  end
end