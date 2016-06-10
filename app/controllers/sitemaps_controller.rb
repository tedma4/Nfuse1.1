class SitemapsController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml {@pages = Page.all}
    end
  end
end