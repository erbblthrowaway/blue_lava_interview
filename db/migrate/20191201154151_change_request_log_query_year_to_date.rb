class ChangeRequestLogQueryYearToDate < ActiveRecord::Migration[5.2]
  def change
    change_column :request_logs, :query, :date
  end
end
