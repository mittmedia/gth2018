class AddDetailsToSm < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :to, :string
    add_column :sms, :from, :string
    add_column :sms, :message, :string
  end
end
