class ChangeContactNoType < ActiveRecord::Migration
  def up
    change_column :api_calls ,:patient_contact_no ,:string
    change_column :users ,:contact_no ,:string
  end

  def down
    change_column :api_calls ,:patient_contact_no ,:integer
    change_column :users ,:contact_no ,:integer

  end
end
