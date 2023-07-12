class CreateJoinTableCoordinatorRegistry < ActiveRecord::Migration[7.0]
  def change
    create_join_table :coordinators, :registries do |t|
      t.index [:coordinator_id, :registry_id], unique: true
      # t.index [:registry_id, :coordinator_id]
    end
  end
end
