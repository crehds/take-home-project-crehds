module Helpers
  def show_products(products)
    puts 'Products:'
    products.each do |product|
      puts "#{product['cant']} #{product['name']} at #{product['price']}"
    end
  end

  def format_taxes(taxes)
    format('%.2f', taxes)
  end

  def show_recipe(products, taxes)
    puts "##{'-' * 40}#"
    puts 'Recipe with taxes'
    show_products(products)
    puts "Sales taxes: #{format_taxes(taxes)}" unless @taxes.zero?
    puts "Total #{calculate_total}"
  end
end
