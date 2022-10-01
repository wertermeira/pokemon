# frozen_string_literal: true

class KindsController < ApplicationController
  before_action :set_kind, only: %i[show update destroy]
  def index
    kinds = Kind.page(params[:page].try(:[], :number)).per(params[:page].try(:[], :size))
    render json: kinds, each_serializer: KindSerializer, status: :ok
  end

  def show
    render json: @kind, serializer: KindSerializer, status: :ok
  end

  def create
    kind = Kind.new(kind_params)
    if kind.save
      render json: kind, serializer: KindSerializer, status: :created
    else
      render json: kind.errors, status: :unprocessable_entity
    end
  end

  def update
    if @kind.update(kind_params)
      render json: @kind, serializer: KindSerializer, status: :accepted
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @kind.destroy
    head :no_content
  end

  private

  def set_kind
    @kind = Kind.find(params[:id])
  end

  def kind_params
    params.require(:kind).permit(:name)
  end
end
