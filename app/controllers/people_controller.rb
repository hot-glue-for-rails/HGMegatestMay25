# frozen_string_literal: true

class PeopleController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Person --gd --related-sets='characteristics'

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_person, only: %i[show edit update destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  def load_person
    @person = Person.find(params[:id])
  end
  
  
  
  def load_all_people
      @people = Person.page(params[:page])

  end

  def index
    load_all_people
    
  end

  def new
    @person = Person.new
    
  end

  def create
    flash[:notice] = +''
    modified_params = modify_date_inputs_on_params(person_params.dup, nil, [])

      
    
    @person = Person.new(modified_params)
    
      
    
    if @person.save
      flash[:notice] = "Successfully created #{@person.name}"
      
      load_all_people
      render :create
    else
      flash[:alert] = "Oops, your person could not be created. #{@hawk_alarm}"
      @action = 'new'
      render :create, status: :unprocessable_entity
    end
  end



  def show
    redirect_to edit_person_path(@person)
  end

  def edit
    @action = 'edit'
    render :edit
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    

    modified_params = modify_date_inputs_on_params(update_person_params.dup, nil, [])
    

    
    
      
      
    if @person.update(modified_params)
      
      
      
      flash[:notice] << "Saved #{@person.name}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update, status: :unprocessable_entity
    else
      flash[:alert] = "Person could not be saved. #{@hawk_alarm}"
      @action = 'edit'
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    
    begin
      @person.destroy
      flash[:notice] = 'Person successfully deleted'
    rescue ActiveRecordError => e
      flash[:alert] = 'Person could not be deleted'
    end
    
    load_all_people
  end



  def person_params
    params.require(:person).permit(:name, characteristic_ids: [])
  end

  
  def update_person_params
    params.require(:person).permit(:name, characteristic_ids: [])
  end
  

  
  def namespace
    
  end
end


