# frozen_string_literal: true

require 'csv'
namespace :import_list do
  desc 'Task to import kinds'
  task kinds: :environment do
    user = User.last
    file = Rails.root.join('vendor/pokemon.csv')
    CSV.parse(File.read(file), headers: true).each do |row|
      Kind.create_with(user: user).find_or_create_by(name: row['Type 1'])
    end
  end

  desc 'Task to import pokemon'
  task pokemons: :environment do
    file = Rails.root.join('vendor/pokemon.csv')
    kinds = Kind.all
    user = User.last
    CSV.parse(File.read(file), headers: true).each do |row|
      kind_ids = []
      kind_ids.push(kinds.find { |kind| kind.name == row['Type 1'] }.id)
      kind_ids.push(kinds.find { |kind| kind.name == row['Type 2'] }.id) if row['Type 2'].present?
      attributes = {
        name: row['Name'], hp: row['HP'], attack: row['Attack'],
        defense: row['Defense'], sp_atk: row['Sp. Atk'], sp_def: row['Sp. Def'],
        speed: row['Speed'], generation: row['Generation'], legendary: row['Legendary'],
        kind_ids: kind_ids, user: user
      }
      pokemon = Pokemon.new(attributes)
      pokemon.save
      puts pokemon.name
    end
  end
end
