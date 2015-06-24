class ContactsController < ApplicationController

  before_action :load_contacts, :only => [:index, :show, :create]
  before_action :load_new_contact, :only => [:index, :new]
  before_action :authenticate_user!
  
  def index

  end

  def new
  end

  def show 
    @contact = Contact.find(params[:id])

  end


  def create
    binding.pry
    @contact = Contact.new(contact_params)
    if params["reminder"].include? "1"
      # if @contact.reminder == "1"
      # TODO: Change so a contact can have multiple reminder dates
        @contact.reminder_date = (Date.today + 1.week)
    elsif params["reminder"].include? "2"
        @contact.reminder_date = (Date.today + 1.month)
    elsif params["reminder"].include? "3"
        @contact.reminder_date = (Date.today + 3.months)
    end

    if @contact.save
      redirect_to user_path(current_user)
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

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    flash[:notice] = "Your contact was deleted successfully."

    redirect_to user_path(current_user)
  end



  private

  def contact_params
    params["contact"].permit(:name, :email, :company, :notes, :reminder, :reminder_date).merge(:user => current_user)
  end

  def load_new_contact
    @contact = Contact.new
  end

  def load_contacts
    @contacts = current_user.contacts
  end

end
