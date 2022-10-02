# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/kinds', type: :request do
  let(:user) { create(:user) }
  let(:token) { 'xxx' }
  let(:Authorization) { authentication(token) }

  before do
    allow(JwtToken).to receive(:decode).with(token).and_return({user_id: user.id})
  end
  path '/kinds' do
    get 'List kinds' do
      let(:kinds_count) { rand(1..10) }
      tags 'Kinds'
      produces 'application/json'
      security [bearer: []]

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
      security [bearer: []]
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
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Kind' }
               }
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
      security [bearer: []]
      parameter name: :id, in: :path

      response 200, 'Success' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Kind' }
               }
        let(:id) { create(:kind).id }
        run_test!
      end

      response 404, 'Not found' do
        let(:id) { 0 }
        run_test!
      end

      response 401, 'Unauthorized' do
        let(:message) { 'token invalid' }
        let(:id) { create(:kind).id }
        before do
          allow(JwtToken).to receive(:decode).with(token).and_raise(JWT::InvalidIssuerError.new(message))
        end

        run_test! do
          expect(json_body.dig('errors')).to eq(message)
        end
      end
    end

    put 'Update kind' do
      tags 'Kinds'
      produces 'application/json'
      consumes 'application/json'
      description 'Update a kind (type, species)'
      security [bearer: []]
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
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Kind' }
               }
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
      description 'Destroy a kind (type, species)'
      security [bearer: []]
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
