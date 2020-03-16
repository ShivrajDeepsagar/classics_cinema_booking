if !User.any?
  #creating user keepworks with admin=>true
  User.create!(name: "Admin", email: "admin@classicsnchill.com", password: "admin123", password_confirmation: "admin123", gender: "male", admin: true)
  User.create!(name: "Sid", email: "sid@classicsnchill.com", password: "sid123", password_confirmation: "sid123", gender: "female", admin: false)

  #movie names array
  movie_name = ["unforgiven", "om", "spiderman", "dirty harry", "swades", "apocalypse now", "interstellar", "batman begins", "kgf", "old boy", "logan", "John Wick: Chapter 2", "little women"]

  #random duration of movies
  duration = [120, 130, 90, 150, 180, 135, 140, 100]

  #inserting in table
  (0...movie_name.length).each do |i|
  	Movie.create!(movie_name: movie_name[i], duration: duration[Random.rand(duration.length)])
  end

  #theater and address array (because of address length array is used instead of hash)
  theaters = ["PVR Cinemas","Srinivasa Theatre",
   "Lakshmi Theater",
   "Sandhya Digital Theater 4K",
   "Sri Thirumala Theaters",
   "Maheshwari Theater",
   "Ravi Cinemas",
   "Sri Balaji Theater",
   "INOX",
   "Urvashi Theater",
   "Lavanya Theatre",
   "PVR Cinemas Soul Space Arena",
   "Parimala and Pradeep Theater",
   "Krishna Theatre",
   "Santosh Theatre",
   "Galaxy Paradise",
   "Sharada Cinemas",
   "Triveni Theatre",
   "Mukunda Theatre"
 ]

  address = [
   "The Forum Mall, 21-22, Adugodi Main Road, Koramangala, Bengaluru, Karnataka 560095",
   "1st Main, S.G.Palaya, Behind Christ College, Bengaluru, Karnataka 560029",
   "104/1, Tavarekere Main Road, Balaji Layout, Near Forum Mall, Bengaluru, Karnataka 560029",
   "VP Road, Madiwala, Stage 1, BTM Layout, Opp.Total Mall, Bengaluru, Karnataka 560068",
   "162, 24th Main, Sector 1, Near-B D A Complex, HSR Layout, Bengaluru, Karnataka 560102",
   "36th Cross Road, Near Jal Bhavan, Bengaluru, Karnataka 560029",
   "Ejipura Main Rd, Gowda Muniswamy Garden, Ejipura, Bengaluru, Karnataka 560047",
   "Vannarpet, K V Temple Street, Vivek Nagar, Bengaluru, Karnataka 560047",
   "5th Floor, Central, 45th Cross, J.P. Nagar 2nd Phase, Bengaluru, Karnataka 560069",
   "Siddiaha Road Junction, 40, Lal Bagh Main Road, Sudhama Nagar, Doddamavalli, Bengaluru, Karnataka 560027",
   "Plot No.14, St Johns Road, Near Rukmini Colony, Sivanchetti Gardens, Hermit Colony, Sivanchetti Gardens, Bengaluru, Karnataka 560042",
   "Soul Space Spirit, 5th Floor, Arena Mall, Opp. EMC Square, Mahadevpura, Marathahalli Ring Road, Doddanekundi, Mahadevapura, Bengaluru, Karnataka 560037",
   "Kalasipalyam Main Rd, Kalasipalam New Exte, Kalasipalya, Bengaluru, Karnataka 560002",
   "Bommanahalli, Bengaluru, Karnataka 560068",
   "K G Road, Majestic Circle, Balepete, Chickpet, Bengaluru, Karnataka 560009",
   "12th Main Road, Bommanahalli Cross, Begur Main Road, Hongasandra, Mico Layout, Hongasandra, Bengaluru, Karnataka 560068",
   "Dharmaraya Swamy Temple Rd, Nagarathpet, Halsurpete, Nagarathpete, Bengaluru, Karnataka 560002",
   "Sampige Theatre",
   "1/2, Sampige Road, Near Mantri Mall, Malleshwaram West, Sheshadripuram, Bengaluru, Karnataka 560003",
  ]

  #inserting values into theater
  (0...theaters.length).each do |i|
  	Theater.create!(theater_name: theaters[i], address: address[i])
  end
end

#getting first and last id of movies and theater
movie_id_first = Movie.first.id
movie_id_last = Movie.last.id

theater_id_first = Theater.first.id
theater_id_last = Theater.last.id

movie_id = movie_id_first

cost = [100, 120, 150, 200, 250, 300, 270, 170]

#inserting values into screening
(theater_id_first..theater_id_last).each do |i|
  if movie_id > movie_id_last
    movie_id = movie_id_first
  end
  Screening.create!(movie_id: movie_id, theater_id: i, ondate: (DateTime.now).to_date, first: true, second: true, third: true, fourth: true, cost: cost[Random.rand(cost.length)])
  movie_id = movie_id + 1
end
