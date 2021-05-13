class AddKanaNameToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :kana_name, :string
  end
end
