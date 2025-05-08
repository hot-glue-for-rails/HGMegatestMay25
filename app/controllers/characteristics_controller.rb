# frozen_string_literal: true

class CharacteristicsController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Characteristic --gd

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_characteristic, only: %i[show edit update destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  def load_characteristic
    @characteristic = Characteristic.find(params[:id])
  end
  
  
  
  def load_all_characteristics
      @characteristics = Characteristic.page(params[:page])

  end

  def index
    load_all_characteristics
    
  end

  def new
    @characteristic = Characteristic.new
    
  end

  def create
    flash[:notice] = +''
    modified_params = modify_date_inputs_on_params(characteristic_params.dup, nil, [])

      
    
    @characteristic = Characteristic.new(modified_params)
    
      
    
    if @characteristic.save
      flash[:notice] = "Successfully created #{@characteristic.name}"
      
      load_all_characteristics
      render :create
    else
      flash[:alert] = "Oops, your characteristic could not be created. #{@hawk_alarm}"
      @action = 'new'
      render :create, status: :unprocessable_entity
    end
  end



  def show
    redirect_to edit_characteristic_path(@characteristic)
  end

  def edit
    @action = 'edit'
    render :edit
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    

    modified_params = modify_date_inputs_on_params(update_characteristic_params.dup, nil, [])
    

    
    
      
      
    if @characteristic.update(modified_params)
      
      
      
      flash[:notice] << "Saved #{@characteristic.name}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update, status: :unprocessable_entity
    else
      flash[:alert] = "Characteristic could not be saved. #{@hawk_alarm}"
      @action = 'edit'
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    
    begin
      @characteristic.destroy
      flash[:notice] = 'Characteristic successfully deleted'
    rescue ActiveRecordError => e
      flash[:alert] = 'Characteristic could not be deleted'
    end
    
    load_all_characteristics
  end



  def characteristic_params
    params.require(:characteristic).permit(:name)
  end

  
  def update_characteristic_params
    params.require(:characteristic).permit(:name)
  end
  

  
  def namespace
    
  end
end


