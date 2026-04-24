class NotificationWorker
  include Sidekiq::Job

  def perform(article_id)
    article = Article.find_by(id: article_id)
    return unless article

    sleep 0.1
    Rails.logger.info "NotificationWorker: processed article #{article_id}"
  end
end
