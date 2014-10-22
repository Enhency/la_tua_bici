class CreateWorkShops < ActiveRecord::Migration
  def change
    create_table :work_shops do |t|
      t.string :name
      t.string :photo
      t.text :description
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.float :latitude
      t.float :longitude
      t.string :mon_wt
      t.string :mon_lt
      t.string :tue_wt
      t.string :tue_lt
      t.string :wed_wt
      t.string :wed_lt
      t.string :thu_wt
      t.string :thu_lt
      t.string :fri_wt
      t.string :fri_lt
      t.string :sat_wt
      t.string :sat_lt
      t.string :sun_wt
      t.string :sun_lt
      t.string :description_typetext
      t.text :description_fulltext

      t.timestamps
    end
  end
end
