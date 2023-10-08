class CreateIcs < ActiveRecord::Migration[7.0]
  def change
    create_table :ics do |t|
      t.string :name
      t.string :furigana

      t.timestamps
    end
  end
end
