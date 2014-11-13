class IdentitiesController < ApplicationController
  def new
    @identity = env['omniauth.identity'] || Identity.new 
  end

  def edit
    @identity = Identity.find(params[:id])
  end
 
  def update
    @identity = Identity.find(params[:id])
    if @identity.update_attributes(params[:identity])
      render 'edit', :flash => { :success => "Your password has been changed." }
    end
  end

end
