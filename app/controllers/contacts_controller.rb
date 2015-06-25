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
    @emails = @contact.emails

  end


  def create

    @contact = Contact.new(contact_params)
    if @contact.save
      if !params["reminder"].nil?
        if params["reminder"].include? "1"
          @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 1.week))
          @reminder.save
        end
        if params["reminder"].include? "2"
          @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 1.month))
          @reminder.save
        end
        if params["reminder"].include? "3"
          @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 3.months))
          @reminder.save
        end
        if params["reminder"].include? "4"
         @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 6.months))
         @reminder.save
        end
      end
      redirect_to user_path(current_user)
   else
    render :index
  end
end

def edit
  @contact = Contact.find(params[:id])
end

def update
  @contact = Contact.find(params[:id])
  @contact.update_attributes(contact_params)
  @contact.reminders.each do |reminder|
    reminder.destroy
  end
  if !params["reminder"].nil?
    if params["reminder"].include? "1"
        @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 1.week))
        @reminder.save
    end
    if params["reminder"].include? "2"
      @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 1.month))
      @reminder.save
    end
    if params["reminder"].include? "3"
      @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 3.months))
      @reminder.save
    end
    if params["reminder"].include? "4"
     @reminder = Reminder.new(:contact_id => @contact.id, :date => (Date.today + 6.months))
     @reminder.save
    end
  end
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
  params["contact"].permit(:name, :email, :company, :notes, :reminder, :reminder_date, :reminder_date_2, :reminder_date_3, :reminder_date_4).merge(:user => current_user)
end

def load_new_contact
  @contact = Contact.new
end

def load_contacts
  @contacts = current_user.contacts
end

end
