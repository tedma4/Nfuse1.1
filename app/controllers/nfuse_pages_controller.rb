class NfusePagesController < ApplicationController
  before_action :signed_in_user, only: [:show, :index,]
  before_action :set_nfuse_page, only: [:show, :index]

  respond_to :html

  def index
    @user = User.find(params[:id])
  end

  def show
  end
  
  def my_nfuse_page
    @my_nfuse_page = NfusePage.my_nfuse_page(current_user)
  end

  private
    def set_nfuse_page
      @nfuse_page = NfusePage.find(params[:id])
    end

    def nfuse_page_params
      params.require(:nfuse_page).permit(:user_id, :shout_id, :owner_id)
    end
end
