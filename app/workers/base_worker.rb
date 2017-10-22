class BaseWorker
  include Sidekiq::Worker

  sidekiq_retry_in do |retry_count|
    # Default:
    # (retry_count ** 4) + 15 + (rand(30) * (retry_count + 1))
    (retry_count ** 6) + 15 + (rand(30) * (retry_count + 1))
  end
end
