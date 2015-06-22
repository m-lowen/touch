class ContactsController < ApplicationController

  before_action :load_contacts, :only => [:index, :show, :create]
  before_action :load_new_contact, :only => [:index, :new]

  def index
  end

  def new
  end

  def show 
    @contact = Contact.find(params[:id])

  end


  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to '/contacts'
    else
      render :index
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id]).update_attributes(contact_params)
    redirect_to contact_path
  end



  private

  def contact_params
    params["contact"].permit(:name, :email, :company, :notes).merge(:user => current_user)
  end

  def load_new_contact
    @contact = Contact.new
  end

  def load_contacts
    @contacts = Contact.all
  end

end
