class SessionView
  def ask_user_for(word)
    puts "#{word.capitalize}?"
    print "> "
    gets.chomp
  end
  
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def successfully_signed_in(employee)
    puts "[#{employee.role.capitalize}] You are signed in!"
  end

  def wrong_credentials
    puts "Sorry, wrong credentials... :(("
  end
end