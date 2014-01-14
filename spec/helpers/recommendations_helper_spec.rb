require 'spec_helper'

describe RecommendationsHelper do
  describe '#normalize' do 
    it "'normalizes' a recipe name"
  end

  describe '#better_capitalize' do 
    it 'only capitalizes certain words'
  end

  describe '#make_concise' do 
    it 'shortens words longer than 27 characters'
  end

  describe '#pull_food_from_db' do 
    it 'retrieves food from the database' do
      pull_food_from_db
      expect(@food).to_not be_nil
    end
  end
end