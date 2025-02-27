# frozen_string_literal: true

class AfterAccountDomainBlockWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default_mastodon'

  def perform(account_id, domain)
    AfterBlockDomainFromAccountService.new.call(Account.find(account_id), domain)
  rescue ActiveRecord::RecordNotFound
    true
  end
end
