class CreateRequestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :request_logs do |t|
      t.integer :query
      t.integer :response

      t.timestamps
    end
  end
end
