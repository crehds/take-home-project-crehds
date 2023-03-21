require 'json'
require './index'

INPUTS = JSON.parse(File.read('./spec/inputs.json'))

RSpec.describe 'ReceipeGenerator Tests' do
  it 'Basic Test 1' do
    app = RecipeGenerator.new(INPUTS['input_1'])
    app.calculate_taxes

    expect(app.calculate_total).to eq(42.32)
    expect(app.taxes).to eq(1.5)
  end

  it 'Basic Test 2' do
    app = RecipeGenerator.new(INPUTS['input_2'])
    app.calculate_taxes

    expect(app.calculate_total).to eq(65.15)
    expect(app.taxes).to eq(7.65)
  end

  it 'Basic Test 3' do
    app = RecipeGenerator.new(INPUTS['input_3'])
    app.calculate_taxes

    expect(app.calculate_total).to eq(98.38)
    expect(app.taxes).to eq(7.90)
  end
end
