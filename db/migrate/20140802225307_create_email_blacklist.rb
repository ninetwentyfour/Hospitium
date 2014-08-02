class CreateEmailBlacklist < ActiveRecord::Migration
  def change
    create_table :email_blacklists do |t|
      t.string :domain
    end
  end
end
