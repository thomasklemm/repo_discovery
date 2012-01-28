class AddTotalWatchersToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :total_watchers, :integer
  end
end
