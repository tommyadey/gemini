class CreateUserVerificationTokens < ActiveRecord::Migration
  def change
    create_table :user_verification_tokens do |t|
      t.integer :user_id,:null => false
      t.string :email, :null => false
      t.string :token, :null => false
      t.string :verification_type, :null => false
      t.boolean :confirmed, :default => 0

      t.timestamps
    end
    add_index :user_verification_tokens, :token, unique: true
  end
end
