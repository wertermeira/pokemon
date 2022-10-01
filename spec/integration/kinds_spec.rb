# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/kinds', type: :request do
  path '/kinds' do
    get 'List kinds' do
      let(:kinds_count) { rand(1..10) }
      tags 'Kinds'
      produces 'application/json'

      response 200, 'List' do
        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref' => '#/components/schemas/Kind' } },
                 links: { '$ref' => '#/components/schemas/Pagination' }
               }
        before { create_list(:kind, kinds_count, :unique_items) }

        run_test! do
          expect(json_body['data'].length).to eq(kinds_count)
        end
      end
    end

    post 'Create kind' do
      tags 'Kinds'
      produces 'application/json'
      consumes 'application/json'
      description 'Create new kind (type, species)'
      parameter name: :kind, in: :body, schema: {
        type: :object,
        properties: {
          kind: {
            type: :object,
            properties: {
              name: { type: :string }
            }
          }
        }
      }

      response 201, 'Created' do
        let(:name) { %w[Grass Pison Fire Bug Water].sample }
        let(:kind) do
          {
            kind: {
              name: name
            }
          }
        end

        run_test! do
          expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
        end
      end

      response 422, 'Unprocessable Entity' do
        let(:kind) do
          {
            kind: {
              name: ''
            }
          }
        end

        run_test! do
          expect(json_body['name']).to include(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  path '/kinds/{id}' do
    get 'Show kind' do
      tags 'Kinds'
      produces 'application/json'
      description 'Show a kind (type, species)'
      parameter name: :id, in: :path

      response 200, 'Success' do
        let(:id) { create(:kind).id }
        run_test!
      end

      response 404, 'Not found' do
        let(:id) { 0 }
        run_test!
      end
    end

    put 'Update kind' do
      tags 'Kinds'
      produces 'application/json'
      consumes 'application/json'
      description 'Update a kind (type, species)'
      parameter name: :id, in: :path
      parameter name: :kind, in: :body, schema: {
        type: :object,
        properties: {
          kind: {
            type: :object,
            properties: {
              name: { type: :string }
            }
          }
        }
      }

      response 202, 'Updated' do
        let(:id) { create(:kind).id }
        let(:name) { %w[Grass Pison Fire Bug Water].sample }
        let(:kind) do
          {
            kind: {
              name: name
            }
          }
        end

        run_test! do
          expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
        end
      end

      response 422, 'Unprocessable Entity' do
        let(:id) { create(:kind).id }
        let(:kind) do
          {
            kind: {
              name: ''
            }
          }
        end

        run_test! do
          expect(json_body['name']).to include(I18n.t('errors.messages.blank'))
        end
      end
    end

    delete 'Destroy a kind' do
      tags 'Kinds'
      produces 'application/json'
      description 'Show a kind (type, species)'
      parameter name: :id, in: :path

      response 204, 'Not contet' do
        let(:id) { create(:kind).id }
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
