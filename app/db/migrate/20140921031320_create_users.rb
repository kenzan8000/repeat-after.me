class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :name
      t.string :profile_image_url
      t.integer :login_count
      t.timestamps
    end
  end
end
