# frozen_string_literal: true

class ThingsController < ApplicationController
  # regenerate this controller with
  # bin/rails generate hot_glue:scaffold Thing --gd --invisible='aaa,bbb,ccc' --pundit

  helper :hot_glue
  include HotGlue::ControllerHelper

  
  before_action :load_thing, only: %i[show edit update destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol == :turbo_stream }
  
  def load_thing
    @thing = Thing.find(params[:id])
  end
  
  
  
  def load_all_things
      @things = policy_scope(Thing).page(params[:page]).includes(:person)

  end

  def index
    load_all_things
    
    authorize @things
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'You are not authorized to perform this action.'
    render 'layouts/error'
  end

  def new
    @thing = Thing.new
    
    authorize @thing
    @action = 'new' 
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'You are not authorized to perform this action.'
    load_all_things
    render :index
  end

  def create
    flash[:notice] = +''
    modified_params = modify_date_inputs_on_params(thing_params.dup, nil, [:ddd])

    
    @thing = Thing.new(modified_params)

      
      
    authorize @thing
    
    if @thing.save
      flash[:notice] = "Successfully created #{@thing.to_label}"
      
      load_all_things
      render :create
    else
      flash[:alert] = "Oops, your Thing could not be created. #{@hawk_alarm}"
      @action = 'new'
      render :create, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    flash[:alert] = "Not authorized."
    @thing.errors.add(:base, e.message)
    render :create, status: :unprocessable_entity

    
  end



  def show
    authorize @thing
    redirect_to edit_thing_path(@thing)
  end

  def edit
    authorize @thing
    @action = 'edit'
    render :edit
  rescue Pundit::NotAuthorizedError
    flash[:notice] = "Editing #{@thing.to_label} not authorized."
    render :index 
  end

  def update
    flash[:notice] = +''
    flash[:alert] = nil
    

    modified_params = modify_date_inputs_on_params(update_thing_params.dup, nil, [:ddd])
    
      
      
   
    
      
      authorize @thing
      

    if @thing.update(modified_params)

    
      
      
      
      flash[:notice] << "Saved #{@thing.to_label}"
      flash[:alert] = @hawk_alarm if @hawk_alarm
      render :update, status: :unprocessable_entity
    else
      flash[:alert] = "Thing could not be saved. #{@hawk_alarm}"
      
      @action = 'edit'
      render :update, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Updating #{@thing.to_label} not authorized. "
      render :update, status: :unprocessable_entity
        
  end

  def destroy
    
    authorize @thing
    begin
      @thing.destroy!
      flash[:notice] = 'Thing successfully deleted'
    rescue ActiveRecord::RecordNotDestroyed => e
      flash[:alert] = 'Thing could not be deleted'
    end
    
    load_all_things
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Deleting #{@thing.to_label} not authorized. "
    render :update
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


