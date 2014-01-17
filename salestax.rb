class SalesTax

	def initialize
		@item_list= []
		@tax_total= 0
		@total= 0 
	end

	def scan(*items)
		items.each do |item|
			@item_list << item
			@tax_total += calc_tax(item)
			@total += calc_total(item)
		end
	end

	def tax_rate
		0.1
	end

	def calc_tax(item)
		total = item.price * tax_rate
		total += 5 - (total % 5) if total % 5 != 0
		return total
	end

	def calc_total(item)
    	item.price + calc_tax(item)
  	end

  	def print(price)
    	price / 100
  	end

  	def reset
    	@item_list= []
    	@tax_total= 0
    	@total = 0
  	end

  	def receipt
    	printout = "\n"
    	@item_list.each do |item|
      	printout << "#{item.quantity} #{item.thing}: #{print(calc_total(item))}" + "\n"
    end
    
    printout << "Sales Taxes: #{print(@tax_total)} \nTotal: #{print(@total)}"
    #reset instance variables for next scan
    reset
    puts printout
  end
end


class Item
	attr_accessor :quantity, :imported, :thing, :exempted, :price
	def initialize(intake)
		array_of_info = intake.split
		@quantity = array_of_info[0].to_i
		@price = array_of_info[array_of_info.length-1].to_f
		@thing = array_of_info[1..-3].join(" ")
		if intake.include? "books"
			@exempted = true
			@thing = "books"
		elsif intake.include? "food"
			@exempted = true
			@thing = "food"
		elsif intake.include? "medicalproducts"
			@exempted = true

		else
			@exempted = false
		end
		if intake.include? "imported"
			@imported = true
		else
			@imported = false
		end
	
	end
	def tax_rate
		tax_rate = 0
		tax_rate = tax_rate + 0.05 if thing.imported == true
		return tax_rate
	end
end

class FoodTax < SalesTax
	def initialize
		@tax_rate = 0
	end	
end

item1 = Item.new("1 book at 11.25")
item2 = Item.new("1 music CD at 14.99")
item3 = Item.new("1 chocolate bar at 0.85")
item4 = Item.new("1 imported box of chocolates at 10.00")
item5 = Item.new("1 imported bottle of perfume at 47.50")
item6 = Item.new("1 imported bottle of perfume at 27.99")
item7 = Item.new("1 bottle of perfume at 18.99")
item8 = Item.new("1 packet of headache pills at 9.75")
item9 = Item.new("1 box of imported chocolates at 11.25")

register= SalesTax.new
puts "OUTPUT"
puts "Output 1:"
register.scan(item1, item2, item3)
register.receipt
puts "Output 2:"
register.scan(item4, item5)
register.receipt
puts "Output 3:"
register.scan(item6, item7, item8, item9)
register.receipt