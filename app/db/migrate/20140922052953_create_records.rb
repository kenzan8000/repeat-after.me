class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :user_id
      t.string :record_title_id
      t.string :facebook_post_id
      t.timestamps
    end
  end
end
