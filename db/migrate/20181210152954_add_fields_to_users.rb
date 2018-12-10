class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string
    add_column :users, :wechatid, :string
    add_column :users, :phone, :string
    add_column :users, :studentid, :string
    add_column :users, :academy, :string
    add_column :users, :sex, :string
  end
end
