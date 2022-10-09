# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/authentications', type: :request do
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:user) { create(:user, password: password) }

  before do
    allow(Rails.application.secrets).to receive(:secret_key_base).and_return(Faker::Internet.password)
  end

  path '/authentications' do
    post 'Authentication' do
      tags 'Authentications'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :authentication, in: :body, schema: {
        type: :object,
        properties: {
          authentication: {
            type: :object,
            properties: {
              email: { type: :string, example: 'petal@petal.com' },
              password: { type: :string, example: '123456' }
            }
          }
        }
      }
      response 201, 'Created token' do
        schema type: :object,
               properties: {
                 token: { type: :string },
                 exp: { type: :string, example: '10-03-2022 13:29' },
                 emal: { type: :string, example: 'petal@petal.com' }
               }
        let(:authentication) do
          {
            authentication: {
              email: user.email,
              password: password
            }
          }
        end
        run_test! do
          expect(JwtToken.decode(json_body['token'])[:user_id]).to eq(user.id)
        end
      end

      response 422, 'Unprocessable Entity' do
        context 'when validate email and password' do
          let(:authentication) do
            {
              authentication: {
                email: 'email',
                password: ''
              }
            }
          end
          let(:expected_error) do
            {
              error: {
                password: [I18n.t('errors.messages.blank')],
                email: ['Invalid email']
              }
            }
          end

          run_test! do
            expect(json_body).to include_json(expected_error)
          end
        end

        context 'when email or password is invalid' do
          let(:authentication) do
            {
              authentication: {
                email: user.email,
                password: Faker::Internet.password
              }
            }
          end

          run_test!
        end
      end
    end
  end
end
