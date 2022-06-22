require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters_grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    answer = params[:answer]
    letters_grid = params[:letters_grid]
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    serialized = URI.open(url).read
    valid = JSON.parse(serialized)["found"]
    on_grid = answer.downcase.chars.all? { |letter| answer.count(letter) <= letters_grid.downcase.count(letter) }
    if valid && on_grid
      @result = "Congratulations, \"#{answer}\" is a valid word!"
      @score = (answer.length) * 10
    elsif valid
      @result = "Sorry, \"#{answer}\" is not on the grid."
      @score = 0
    else
      @result = "Sorry, \"#{answer}\" is not in the English dictionary."
      @score = 0
    end
  end
end
