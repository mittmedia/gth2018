class AddHateToSms < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :is_hate, :boolean
  end
end
