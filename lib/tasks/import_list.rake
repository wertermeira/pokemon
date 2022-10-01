# frozen_string_literal: true

require 'csv'
namespace :import_list do
  desc 'Task to import kinds'
  task kinds: :environment do
    file = Rails.root.join('vendor/pokemon.csv')
    CSV.parse(File.read(file), headers: true).each do |row|
      Kind.find_or_create_by(name: row['Type 1'])
    end
  end

  desc 'Task to import pokemon'
  task pokemons: :environment do
    file = Rails.root.join('vendor/pokemon.csv')
    CSV.parse(File.read(file), headers: true).each do |row|
      attributes = {
        name: row['Name'], hp: row['HP'], attack: row['Attack'],
        defense: row['Defense'], sp_atk: row['Sp. Atk'], sp_def: row['Sp. Def'],
        speed: row['Speed'], generation: row['Generation'], legendary: row['Legendary']
      }
      pokemon = Pokemon.new(attributes)
      pokemon.save
      pokemon.kinds.find_or_create_by(name: row['Type 1'])
      pokemon.kinds.find_or_create_by(name: row['Type 2']) if row['Type 2'].present?
      puts pokemon.name
    end
  end
end
