class AdminController < ApplicationController

  before_action :check_access

  def add_movies
    movie = Movie.new
    @errors = []
  end

  def create_movies
    movie = Movie.new(movie_params)
    if movie.save

      if movie.image_url == "none"
        movie_name = movie.movie_name.split(' ').join('+')

        page_url = "http://www.imdb.com/find?ref_=nv_sr_fn&q="+movie_name+"&s=tt"

        page = Nokogiri::HTML(open(page_url))
        links_array = page.css('tr.findResult.odd')
        image_link = links_array[0].css('a')[0]["href"]
        image_url = "http://www.imdb.com/"+image_link
        image = Nokogiri::HTML(open(image_url))
        image_array = image.css("div.poster")[0]
        image_url = image_array.css('img')[0]["src"]

        movie.image_url = image_url
        movie.save
      end

      flash[:success] = "Post created successfully"
      redirect_to :back
    else
      @errors = movie.errors.full_messages
      render 'add_movies'
    end
  end

  def add_theater
    theater = Theater.new
    @errors=[]
  end

  def create_theater
    theater = Theater.new(theater_params)
    if theater.save
      flash[:success] = "Theater Added successfully"
      redirect_to :back
    else
      @errors = theater.errors.full_messages
      render 'add_theater'
    end
  end

  def create_screening
    screening = Screening.new
    @errors = []
  end

  def show_screening
    screening = Screening.new(screening_params)
    if screening.save
      flash[:success] = "Screening Created Successfully"
      redirect_to :back
    else
      @errors = screening.errors.full_messages
      render 'create_screening'
    end
  end

  private

    def movie_params
      params.require(:movie).permit(:movie_name, :duration)
    end

    def theater_params
      params.require(:theater).permit(:theater_name, :address)
    end

    def screening_params
        params.require(:screening).permit(:movie_id, :theater_id, :ondate, :first, :second, :third, :fourth, :cost)
    end

    def check_access
      if !current_user.try(:admin?)
        flash[:danger] = "you are not authorized to view this page"
        redirect_to(root_url)
      end
    end

end
