require 'rails_helper'
require 'database_cleaner'
require 'sidekiq/testing'

RSpec.configure do |config|
  config.before :each do
    Sidekiq::Worker.clear_all
    DatabaseCleaner.strategy = :transaction
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
