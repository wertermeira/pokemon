# frozen_string_literal: true

class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[show update destroy]
  def index
    pokemons = Pokemon.includes(:kinds).page(params[:page].try(:[], :number)).per(params[:page].try(:[], :size))
    render json: pokemons, each_serializer: PokemonSerializer, status: :ok, include: 'kinds'
  end

  def show
    render json: @pokemon, serializer: PokemonSerializer, status: :ok, include: 'kinds'
  end

  def create
    pokemon = Pokemon.new(pokemon_params)
    if pokemon.save
      render json: pokemon, serializer: PokemonSerializer, status: :created, include: 'kinds'
    else
      render json: pokemon.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon, serializer: PokemonSerializer, status: :accepted, include: 'kinds'
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon.destroy
    head :no_content
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary,
                                    kind_ids: [])
  end
end
