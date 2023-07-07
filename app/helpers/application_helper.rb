module ApplicationHelper
  def display_number(number)
    (number % 1).zero? ? number.to_i : number
  end
end
