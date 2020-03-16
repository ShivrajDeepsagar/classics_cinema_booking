class BookingsController < ApplicationController

  before_action :check_login_status, except: [:home]


  def home
    @movie = Movie.all
    @movie.each do |movie|
      if movie.image_url == "none"
        movie_name = movie.movie_name.split(' ').join('+')

        page_url = "http://www.imdb.com/find?ref_=nv_sr_fn&q="+movie_name+"&s=tt"

        page = Nokogiri::HTML(open(page_url))
        links_array = page.css('tr.findResult.odd')
        image_link = links_array[0].css('a')[0]["href"]
        image_url = "http://www.imdb.com/"+image_link
        image = Nokogiri::HTML(open(image_url))
        image_array = image.css("div.poster")[0]
        image_url1 = image_array.css('img')[0]["src"] if image_array.present?

        movie.image_url = image_url1 if image_url.present?
        movie.save
      end
    end

    if Screening.last.ondate.to_date != Date.today
      Rails.application.load_seed
    end
  end

  def book_now
    @screenings = Movie.find(params[:movie_id]).screenings.ondate
  end

  def buy_ticket
    screening_id = params[:screening_id].to_i
    show = params[:show].to_i

    @screenings = Screening.find(screening_id)
    gender = current_user.gender  # to calculate discount

    session[:discout] = 0
    if gender.to_s.downcase == "female"
      session[:discout] = 5
    end
    cost = @screenings.cost
    session[:cost] = cost.to_i

    buyticket = Buyticket.new
    errors = []
    @display = [screening_id, show, gender, cost]
  end

  def buy_ticket_details
    buyticket = Buyticket.new(params[:buyticket])
    if buyticket.valid?
      session[:buyticket] = buyticket
      redirect_to selectseats_path
    else
      errors = buyticket.errors.full_messages
      flash[:danger] = 'please select tickets'
      redirect_to :back
    end
  end

  def select_seats
    @ticket_details = session[:buyticket]
    session[:screening_id] = @ticket_details["screening_id"]
    session[:show] = @ticket_details["show"]
    session[:tickets] = @ticket_details["tickets"]
    @seats = Screening.find(session[:screening_id]).seats
  end

  def seats_details
      selected_seats = params[:select_seats]
      seats = selected_seats.map {|k,v| v=='1' ? k : nil }.compact
    if seats.length < session[:tickets].to_i
      flash[:danger] = "please select " + session[:tickets] +" tickets to continue"
      redirect_to selectseats_path
    else
      session[:seats] = seats
      redirect_to applycoupon_path
    end
  end

  def apply_coupon
  end

  def coupon_validation
    coupon_code = params[:apply_coupon][:code]
    if session[:coupon] != coupon_code
      if !coupon_code.nil?
        coupon = Coupon.find_by(code: coupon_code.upcase)
        if coupon
          session[:coupon] = coupon_code
          flash.now[:success] ="Coupon applied successfully"
          session[:discout] = session[:discout] + coupon.discount
          redirect_to payment_path
        else
          flash.now[:danger] ="Coupon not valid"
          render :apply_coupon
        end
      end
    else
      flash[:errors] ="Coupon already applied"
      redirect_to applycoupon_path
    end

  end

  def continue
    redirect_to payment_path
  end


  def payment
      cost = session[:cost]
      discout = session[:discout]
      @total_cost = (cost-((discout / 100.0) * cost)) * session[:tickets].to_i

      reservation = Reservation.new
      seat = Seat.new
      @payment = Payment.new #except this i have removed all other instance variables
  end

  def payment_details
    user_id = current_user.id
    screening_id = session[:screening_id].to_i
    tickets = session[:tickets].to_i
    show = session[:show].to_i

    @payment = Payment.new(params[:payment]) #except this i have removed all other instance variables
    if @payment.valid?

        reservation = Reservation.new(screening_id: screening_id, user_id: user_id,reserved: true, paid: true, active: true, show_num: session[:show])
        if reservation.save
          screenings_info = Screening.find(screening_id)
            if show == 1
              present_seats = screenings_info.first_seats
            elsif show == 2
              present_seats = screenings_info.second_seats
            elsif show == 3
              present_seats = screenings_info.third_seats
            elsif show == 4
              present_seats = screenings_info.fourth_seats
            end
        end

        present_seats = present_seats - tickets

        update_seats_in_screening = Screening.find(screening_id)

        if show == 1
          update_seats_in_screening.first_seats = present_seats
        elsif show == 2
          update_seats_in_screening.second_seats = present_seats
        elsif show == 3
          update_seats_in_screening.third_seats = present_seats
        elsif show == 4
          update_seats_in_screening.fourth_seats = present_seats
        end

        if update_seats_in_screening.save
           seat = Seat.create(screening_id: screening_id, seat_details: session[:seats], reservation_id: reservation.id, user_id: user_id)
           Transactions.create(seat_id: seat.id, reservation_id: reservation.id, screening_id: screening_id)
           redirect_to bookings_path
        else
          reservation.destroy
          reservation.save
          flash[:danger] = "some thing went wrong please try again"
          redirect_to root_path
        end

    else
      render :payment
    end
  end


  private

    def check_login_status
      if !logged_in?
        flash[:error] = 'Please login to Continue'
        redirect_to root_path
      end
    end
end
