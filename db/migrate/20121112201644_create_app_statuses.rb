class CreateAppStatuses < ActiveRecord::Migration
  def change
    create_table :app_statuses do |t|
      t.string :status, :null => true
      t.string :status_message, :null => true
      t.timestamps
    end
  end
end