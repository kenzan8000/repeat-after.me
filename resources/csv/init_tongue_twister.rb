require 'active_record'
require 'csv'


TONGUE_TWISTERS_CSV = "./../resources/csv/tongue_twister.csv"


ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./db/development.db"
)


class TongueTwister < ActiveRecord::Base
end


TongueTwister.delete_all


reader = CSV.open(TONGUE_TWISTERS_CSV, 'r', :col_sep => "\t")
reader.each do |row|
  tongue_twister = TongueTwister.new do |t|
    t.text = row[0]
  end
  tongue_twister.save
end
