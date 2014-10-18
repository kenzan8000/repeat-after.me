class CreateRecordComments < ActiveRecord::Migration
  def change
    create_table :record_comments do |t|
      t.string :record_id
      t.string :user_id
      t.string :text
      t.timestamps
    end
  end
end
