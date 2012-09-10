class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table    :zip_codes do |t|
      t.string      :zip,         :null => false,   :limit => 5
      t.string      :state_code,  :null => false,   :limit => 2

      t.float      :latitude,    :null => false,   :limit => 10
      t.float      :longitude,   :null => false,   :limit => 10

      t.string      :city,                          :limit => 30
      t.string      :state,       :null => false,   :limit => 20

      t.timestamps
    end
  end
end
