class AddUserToGroup < ActiveRecord::Migration
  def change
    add_reference :groups, :user, index: true
  end
end
