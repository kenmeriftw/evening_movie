require_relative 'lib/movie'
require_relative 'lib/movies_collection'

require 'nokogiri'
require 'open-uri'

URL = "https://ru.wikipedia.org/wiki/250_%D0%BB%D1%83%D1%87%D1%88%D0%B8%D1%85_" \
"%D1%84%D0%B8%D0%BB%D1%8C%D0%BC%D0%BE%D0%B2_%D0%BF%D0%BE_%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B8_IMDb".freeze

puts 'Выберите режиссера и введите номер'

movies = MoviesCollection.from_list(URL)

puts 'Фильм какого режиссера Вы хотите сегодня посмотреть?'

puts movies.directors_list

print '> '
user_input = STDIN.gets.to_i

if user_input.between?(0, movies.selected_directors.size)
  random_movie = movies.select(user_input - 1)
else
  puts 'Вы ввели некорректное значение.'
  exit
end

puts 'Сегодня вечером рекомендуем посмотреть этот фильм:'
puts random_movie.sample
