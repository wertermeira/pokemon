# frozen_string_literal: true

namespace :populate do
  desc 'Task populate user'
  task user: :environment do
    attributes = { email: 'petal@petal.com', password: '123456' }
    user = User.new(attributes)
    puts user.email if user.save
  end
end
