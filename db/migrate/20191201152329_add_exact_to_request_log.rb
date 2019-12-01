class AddExactToRequestLog < ActiveRecord::Migration[5.2]
  def change
    add_column :request_logs, :exact, :boolean
  end
end
