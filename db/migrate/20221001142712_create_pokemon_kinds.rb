class CreatePokemonKinds < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_kinds do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :kind, null: false, foreign_key: true

      t.timestamps
    end
  end
end
