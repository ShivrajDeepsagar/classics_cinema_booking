module BookingHelper
  def show_time(number)
    if number == 1
      return '10 Am', 10
    elsif number == 2
      return '1 Pm', 13
    elsif number == 3
      return '4 Pm', 16
    elsif number == 4
      return '7 Pm', 19
    end
  end
end
