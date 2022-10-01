# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          Kind: {
            type: :object,
            properties: {
              id: { type: :string, example: '1' },
              type: { type: :string, example: 'kinds' },
              attributes: {
                type: :object,
                properties: {
                  name: { type: :string, example: 'Water' },
                  created_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  updated_at: { type: :string, example: '2020-04-26T10:20:00.000Z' }
                }
              }
            }
          },
          KindRelation: {
            type: :object,
            properties: {
              id: { type: :integer },
              type: { type: :string, example: 'kinds' }
            }
          },
          Pokemon: {
            type: :object,
            properties: {
              id: { type: :string, example: '1' },
              type: { type: :string, example: 'pokemons' },
              attributes: {
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
                  legendary: { type: :boolean },
                  created_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  updated_at: { type: :string, example: '2020-04-26T10:20:00.000Z' }
                }
              },
              relationships: {
                type: :object,
                properties: {
                  kinds: {
                    type: :array,
                    items: { '$ref' => '#/components/schemas/KindRelation' }
                  }
                }
              }
            }
          },
          Pagination: {
            type: :object,
            properties: {
              self: { type: :url, example: 'http://example.com/articles' },
              next: { type: :url, example: 'http://example.com/articles?page[offset]=2' },
              last: { type: :url, example: 'http://example.com/articles?page[offset]=10' }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  config.swagger_format = :yaml
end
