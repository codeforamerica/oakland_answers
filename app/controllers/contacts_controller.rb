class ContactsController < ApplicationController
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html
      format.json { render json: @contacts }
    end
  end

  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @contact }
    end
  end


end
