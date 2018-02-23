class CreateSms < ActiveRecord::Migration[5.1]
  def change
    create_table :sms do |t|
      t.string :form

      t.timestamps
    end
  end
end
