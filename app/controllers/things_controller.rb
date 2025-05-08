# frozen_string_literal: true

class ThingsController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Thing --gd

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_thing, only: %i[show edit update destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  def load_thing
    @thing = Thing.find(params[:id])
  end
  
  
  
  def load_all_things
      @things = Thing.includes(:person).page(params[:page])

  end

  def index
    load_all_things
    
  end

  def new
    @thing = Thing.new
    
  end

  def create
    flash[:notice] = +''
    modified_params = modify_date_inputs_on_params(thing_params.dup, nil, [:ddd])

      
    
    @thing = Thing.new(modified_params)
    
      
    
    if @thing.save
      flash[:notice] = "Successfully created #{@thing.to_label}"
      
      load_all_things
      render :create
    else
      flash[:alert] = "Oops, your thing could not be created. #{@hawk_alarm}"
      @action = 'new'
      render :create, status: :unprocessable_entity
    end
  end



  def show
    redirect_to edit_thing_path(@thing)
  end

  def edit
    @action = 'edit'
    render :edit
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    

    modified_params = modify_date_inputs_on_params(update_thing_params.dup, nil, [:ddd])
    

    
    
      
      
    if @thing.update(modified_params)
      
      
      
      flash[:notice] << "Saved #{@thing.to_label}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update, status: :unprocessable_entity
    else
      flash[:alert] = "Thing could not be saved. #{@hawk_alarm}"
      @action = 'edit'
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    
    begin
      @thing.destroy
      flash[:notice] = 'Thing successfully deleted'
    rescue ActiveRecordError => e
      flash[:alert] = 'Thing could not be deleted'
    end
    
    load_all_things
  end



  def thing_params
    params.require(:thing).permit(:person_id, :bbb, :ccc, :ddd, :eee, :fff, :iii, :sss, :ttt, :mmm)
  end

  
  def update_thing_params
    params.require(:thing).permit(:person_id, :bbb, :ccc, :ddd, :eee, :fff, :iii, :sss, :ttt, :mmm)
  end
  

  
  def namespace
    
  end
end


