class CustomerView 
  def ask_user_for(word)
    puts "#{word.capitalize}?"
    print "> "
    gets.chomp
  end

  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} (lives in: #{customer.address})"
    end
  end
end