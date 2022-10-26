class OrderView
  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} will be delivered by #{order.employee.username} 
      to #{order.customer.name} (Address: #{order.customer.address}) "
    end
  end

  def ask_user_for(word)
    puts "#{word.capitalize}?"
    print "> "
    gets.chomp
  end
end