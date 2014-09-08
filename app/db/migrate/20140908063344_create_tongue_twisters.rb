class CreateTongueTwisters < ActiveRecord::Migration
  def change
    create_table :tongue_twisters do |t|
      t.string :text
      t.timestamps
    end
  end
end
