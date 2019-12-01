class RequestLog < ApplicationRecord
  def self.all_logs
    RequestLog.order('id desc').limit(50)
  end
end
