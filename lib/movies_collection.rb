require 'nokogiri'
require 'open-uri'
require 'pry'

class MoviesCollection

  attr_reader :movies, :selected_directors, :selected_movies

  def self.from_list(url)
    # парсим вики
    doc = Nokogiri::HTML(URI.parse(url).open)

    nodes = []
    movies_nodes = []
    movies = []

    # достаем все элементы <td>, загоняем в массив нод
    doc.css('td').map { |node| nodes << node.text }

    # обрезаем два первых элемента - лишние
    2.times { nodes.delete_at(0) }
    # делим на массивы по пять записей (информация о каждом фильме в отдельный подмассив)
    nodes.each_slice(5).map { |movie| movies_nodes << movie }
    # удаляем первый элемент - порядковый номер в рейтинге, он нам пока не нужен
    movies_nodes.map do |movie|
      movie.delete_at(0)
    end

    movies_nodes.map do |movie|
      movies << Movie.new(
        title: movie[0],
        year: movie[1],
        director: movie[2],
        genre: movie[3].chomp
      )
    end
    new(movies)
  end

  def initialize(movies = [])
    @movies = movies
    @directors = @movies.map(&:director).uniq
  end

  def directors_list
    @selected_directors = []
    @directors.map.with_index(1) { |director, index| @selected_directors << "#{index}. #{director}" }
    @selected_directors
  end

  def select(director_index)
    @selected_movies = []
    @movies.map do |movie|
      @selected_movies << movie if movie.director == @directors[director_index]
    end
    @selected_movies
  end
end
