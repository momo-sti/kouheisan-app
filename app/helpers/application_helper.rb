module ApplicationHelper
  def display_number(number)
    number % 1 == 0 ? number.to_i : number
  end
end
