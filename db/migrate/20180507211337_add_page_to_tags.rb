class AddPageToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :page, foreign_key: true
  end
end
