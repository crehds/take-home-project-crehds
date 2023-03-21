require 'json'

INPUTS = JSON.parse(File.read('./spec/inputs.json'))

EXCLUDE_BASIC_TAX = %w[books medicine food].freeze

class RecipeGenerator
  attr_accessor :products, :taxes

  def initialize(products)
    @products = products
    @taxes = 0
  end

  def process_product
    show_products
    calculate_taxes
    show_recipe
  end

  def show_products
    puts 'Products:'
    products.each do |product|
      puts "#{product['cant']} #{product['name']} at #{product['price']}"
    end
  end

  def basic_tax?(product)
    EXCLUDE_BASIC_TAX.include?(product['type'])
  end

  def import_tax?(product)
    product['imported'] == true
  end

  def round(tax)
    last_digit = tax.to_s.chars.last.to_i
    last_digit > 5 ? tax.round(1) : tax
  end

  def get_tax(tax, product)
    result_tax = (product['price'] * tax).truncate(2)
    result_tax = round(result_tax) * product['cant']
    new_tax = @taxes + result_tax
    @taxes = new_tax
    result_tax
  end

  def calculate_taxes
    @products = products.map do |product|
      tax1 = 0
      tax2 = 0
      tax1 = get_tax(0.1, product) unless basic_tax?(product)
      tax2 = get_tax(0.05, product) if import_tax?(product)

      product['price'] = format('%.2f', ((product['price'] * product['cant']) + tax1 + tax2)).to_f
      product
    end
  end

  def print_taxes
    format('%.2f', taxes)
  end

  def calculate_total
    products.inject(0) { |sum, product| sum + product['price'] }.truncate(2)
  end

  def show_recipe
    puts "##{'-' * 40}#"
    puts 'Recipe with taxes'
    show_products
    puts "Sales taxes: #{print_taxes}" unless @taxes.zero?
    puts "Total #{calculate_total}"
  end
end

# input_number = ARGV.shift

# app = RecipeGenerator.new(INPUTS["input_#{input_number}"])
# app.process_product
