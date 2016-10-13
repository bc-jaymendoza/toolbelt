class AddInterval < ActiveRecord::Migration[5.0]
  def change
    create_table :intervals do |t|
      t.integer :api_id
      t.integer :calls_offered
      t.integer :call_handled
      t.bigint :timestamp
    end
  end
end
