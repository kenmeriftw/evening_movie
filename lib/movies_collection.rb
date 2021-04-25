require 'nokogiri'
require 'open-uri'
require 'pry'

class MoviesCollection

  attr_reader :movies, :selected_directors, :selected_movies

  def self.from_list(url)
    movies = []
    # парсим страницу Википедии
    doc = Nokogiri::HTML(URI.parse(url).open)
    # достаем элементы из table, разделяем их на массивы
    movies_nodes = doc.css('table').text.split("\n\n\n").map { |el| el.split("\n").to_a }  
    # убираем два первых элемента - служебные поля таблицы
    2.times { movies_nodes.delete_at(0) }
    # формируем коллекцию
    movies_nodes.map do |el|
      movies << Movie.new(
        rank: el[0],
        title: el[1],
        year: el[2],
        director: el[3],
        genre: el[4]
      )
    end
    new(movies)
  end

  def initialize(movies = [])
    @movies = movies
  end

  def directors_list
    @directors = @movies.map(&:director).uniq
    @directors.map.with_index(1) { |director, index| "#{index}. #{director}" }
  end

  def select(director_index)
    @movies.select { |el| el.director == @directors[director_index - 1] }
  end
end
