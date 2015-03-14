class Users::NfusedPagesController < ApplicationController

  def create
    if @nfuse_page = NfusePage.find_by(social_id: params[:id], social_key: params[:key])
       render json: { nfuse_page: @nfuse_page }
    else
      @nfuse_page = NfusePage.build(params)
      render json: { nfuse_page: @nfuse_page }
    end
  end

end
