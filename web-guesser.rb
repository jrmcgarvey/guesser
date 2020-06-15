require 'sinatra'

enable :sessions

get '/' do
  session.delete(:guesses)
  session[:guess_count] = 0
  session[:secret] = rand(100) + 1
  @background = "White"
  erb :guess
end

post '/' do
  this_guess = params[:guess]
  if this_guess == ""
    @message = "Your guess can't be blank."
    erb :guess
  else
    this_guess = this_guess.to_i
    session[:guess_count] += 1
    guesses = session[:guesses]
    if guesses.nil?
      guesses = []
    end
    if this_guess <= session[:secret] - 10
      guesses << "You guessed #{this_guess}. That's way too low."
      @background = "LightBlue"
    elsif this_guess < session[:secret]
      guesses << "You guessed #{this_guess}. That's close but too low."
      @background = "Cyan"
    elsif this_guess == session[:secret]
      guesses << "You guessed #{this_guess}.  That is correct!"
    elsif this_guess < session[:secret] + 10
      guesses << "You guessed #{this_guess}. That's close but too high."
      @background = "LightPink"
    else
      guesses << "You guessed #{this_guess}.  That's way too high."
      @background = "Pink"
    end
    session[:guesses]=guesses
    if this_guess == session[:secret]
      @message = "You win!!"
      @background = "Yellow"
      erb :play_again
    elsif session[:guess_count] >= 7
      @message = "You are out of guesses. You lose."
      @background = "Gray"
      erb :play_again
    else
      @message = nil
      erb :guess
    end
  end
end

post '/playagain' do
  session.delete(:guesses)
  session[:guess_count] = 0
  @message = nil
  session[:secret] = rand(100) + 1
  @background = "White"
  erb :guess
end
