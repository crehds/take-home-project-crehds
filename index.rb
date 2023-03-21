PRODUCTS = [
  {
    cant: 2,
    name: 'book',
    price: 12.49,
    type: 'books',
    imported: false
  },
  {
    cant: 1,
    name: 'music CD',
    price: 14.99,
    type: 'music',
    imported: false
  },
  {
    cant: 1,
    name: 'chocolate bar',
    price: 0.85,
    type: 'food',
    imported: false
  }
].freeze

EXCLUDE_BASIC_TAX = %w[books medicine food].freeze

class ReceipeGenerator
  attr_accessor :products, :taxes

  def initialize(products)
    @products = products
    @taxes = 0
  end

  def start
    show_products
    calculate_taxes
    recipe
  end

  def show_products
    puts 'Products:'
    products.each do |product|
      puts "#{product[:cant]} #{product[:name]} at #{product[:price]}"
    end
  end

  def basic_tax?(product)
    EXCLUDE_BASIC_TAX.include?(product[:type])
  end

  def import_tax?(product)
    product[:imported] == true
  end

  def apply_tax(tax, product)
    tax = (product[:price] * tax).round(2)
    new_price = (product[:price] + tax).truncate(2)
    product[:price] = new_price
    new_tax = (@taxes + tax).truncate(2)
    @taxes = new_tax
    product
  end

  def calculate_taxes
    @products = products.map do |product|
      product = apply_tax(0.1, product) unless basic_tax?(product)
      product = apply_tax(0.05, product) if import_tax?(product)

      product
    end
  end

  def print_taxes
    format('%.2f', taxes)
  end

  def calculate_total
    products.inject(0) do |sum, product|
      temp = product[:price] * product[:cant]
      sum + temp
    end
  end

  def recipe
    puts "##{'-' * 40}#"
    puts 'Recipe with taxes'
    show_products
    puts "Sales taxes: #{print_taxes}" unless @taxes.zero?
    puts "Total #{calculate_total}"
  end
end

app = ReceipeGenerator.new(PRODUCTS)
app.start
