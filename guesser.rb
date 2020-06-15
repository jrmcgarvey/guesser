while true
  win = false
  secret = rand(100) + 1
  puts "Guess the secret number, which is from 1 to 100."
  7.times do
    g = gets().to_i
    if g <= secret - 10
      puts("Your guess is way too low.")
    elsif g< secret
      puts("Your guess is close but too low.")
    elsif g == secret
      win = true
      break
    elsif g < secret + 10
      puts "Your guess is close but too high."
    else
      puts "Your guess is way too high."
    end
  end
  if win
    puts "You win!"
  else
    puts "You are out of guesses. You lose!"
  end
  puts "Would you like to play again (y/n)"
  if gets().downcase()[0] == "n"
    break;
  end
end
