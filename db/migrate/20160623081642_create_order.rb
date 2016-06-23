class CreateOrder < ActiveRecord::Migration
  def change
    create_table "order", force: :cascade do |t|
      t.decimal :base_price
      t.decimal :discount
      t.decimal :surcharge
    end
  end
end