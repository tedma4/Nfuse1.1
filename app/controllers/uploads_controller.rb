class UploadsController < ApplicationController
  #This controlls the Nfuse dropbox
  def new
    #This starts the new upload process
    @upload = Upload.new
  end
 
  def create
    #This creates an upload and shows it
    @upload = Upload.create(upload_params)
    if @upload.save
      # send success header
      render json: { message: "success", fileID: @upload.id }, :status => 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 400
    end     
  end
 
  def destroy
    #This deletes an upload
    @upload = Upload.find(params[:id])
    if @upload.destroy    
      render json: { message: "File deleted from server" }
    else
      render json: { message: @upload.errors.full_messages.join(',') }
    end
  end
 
  private
  def upload_params
    #These are the kinds of permitted files that can be uploaded
    params.require(:upload).permit(:image)
  end
end