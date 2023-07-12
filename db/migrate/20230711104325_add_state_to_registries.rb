class AddStateToRegistries < ActiveRecord::Migration[7.0]
  def change
    add_column :registries, :state, :string
  end
end
