# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/pokemons', type: :request do
  path '/pokemons' do
    get 'List pokemon' do
      let(:pokemon_count) { rand(1..10) }
      tags 'Pokemons'
      produces 'application/json'

      response 200, 'List' do
        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref' => '#/components/schemas/Pokemon' } },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Kind' } },
                 links: { '$ref' => '#/components/schemas/Pagination' }
               }
        before { create_list(:pokemon, pokemon_count, :unique_items) }

        run_test! do
          expect(json_body['data'].length).to eq(pokemon_count)
        end
      end
    end

    post 'Create Pokemon' do
      tags 'Pokemons'
      produces 'application/json'
      consumes 'application/json'
      description 'Create Pokemon'
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          pokemon: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Pikatchu' },
              total: { type: :integer },
              hp: { type: :integer },
              attack: { type: :integer },
              sp_atk: { type: :integer },
              sp_def: { type: :integer },
              speed: { type: :integer },
              defense: { type: :integer },
              generation: { type: :integer },
              legendary: { type: :boolean }
            }
          }
        }
      }

      response 201, 'Created' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Pokemon' },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Kind' } }
               }
        let(:name) { Faker::Games::Pokemon.name }
        let(:kinds) { create_list(:kind, 2, :unique_items) }
        let(:pokemon) do
          {
            pokemon: {
              name: name,
              hp: 10,
              attack: 20,
              sp_atk: 20,
              sp_def: 15,
              speed: 100,
              generation: 1,
              defense: 1,
              legendary: true,
              kind_ids: kinds.pluck(:id)
            }
          }
        end

        run_test! do
          expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
        end
      end

      response 422, 'Unprocessable Entity' do
        let(:pokemon) do
          {
            pokemon: {
              name: '',
              hp: 10,
              attack: 20,
              sp_atk: 20,
              sp_def: 15,
              speed: 100,
              generation: 1,
              defense: 1,
              legendary: true,
              kind_ids: []
            }
          }
        end

        run_test! do
          expect(json_body['name']).to include(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  path '/pokemons/{id}' do
    get 'Show Pokemon' do
      tags 'Pokemons'
      produces 'application/json'
      description 'Show a Pokemon (type, species)'
      parameter name: :id, in: :path

      response 200, 'Success' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Pokemon' },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Kind' } }
               }
        let(:id) { create(:pokemon, :with_kinds).id }
        run_test!
      end

      response 404, 'Not found' do
        let(:id) { 0 }
        run_test!
      end
    end

    put 'Update pokemon' do
      tags 'Pokemon'
      produces 'application/json'
      consumes 'application/json'
      description 'Update a pokemon'
      parameter name: :id, in: :path
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          pokemon: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Pikatchu' },
              total: { type: :integer },
              hp: { type: :integer },
              attack: { type: :integer },
              sp_atk: { type: :integer },
              sp_def: { type: :integer },
              speed: { type: :integer },
              defense: { type: :integer },
              generation: { type: :integer },
              legendary: { type: :boolean }
            }
          }
        }
      }

      response 202, 'Updated' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Kind' }
               }
        let(:the_pokemon) { create(:pokemon, :with_kinds) }
        let(:id) { the_pokemon.id }
        let(:name) { Faker::Games::Pokemon.name }
        let(:kind_ids) { [] }
        let(:pokemon) do
          {
            pokemon: {
              name: name,
              hp: 10,
              attack: 20,
              sp_atk: 20,
              sp_def: 15,
              speed: 100,
              generation: 1,
              defense: 1,
              legendary: true,
              kind_ids: kind_ids
            }
          }
        end

        context 'when change name' do
          run_test! do
            expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
          end
        end

        context 'when remove kinds' do
          run_test! do
            expect(json_body.dig('data', 'relationships', 'kinds', 'data').length).to be_zero
          end
        end

        context 'when change kinds' do
          let(:kind_ids) { create_list(:kind, rand(1..3), :unique_items).pluck(:id) }

          run_test! do
            relationship_ids = json_body.dig('data', 'relationships', 'kinds', 'data').map { |kind| kind['id'].to_i }
            expect(relationship_ids).to match_array(kind_ids)
          end
        end
      end

      response 422, 'Unprocessable Entity' do
        let(:id) { create(:pokemon).id }
        let(:pokemon) do
          {
            pokemon: {
              name: ''
            }
          }
        end

        run_test! do
          expect(json_body['name']).to include(I18n.t('errors.messages.blank'))
        end
      end
    end

    delete 'Destroy a Pokemon' do
      tags 'Pokemons'
      produces 'application/json'
      description 'Destroy a Pokemon'
      parameter name: :id, in: :path

      response 204, 'Not contet' do
        let(:id) { create(:pokemon).id }
        run_test! do
          expect(Kind.find_by(id: id)).to be_falsey
        end
      end

      response 404, 'Not found' do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
