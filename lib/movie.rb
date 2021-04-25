class Movie
  attr_accessor :title, :director, :year, :genre

  def initialize(params)
    @title = params[:title]
    @director = params[:director]
    @year = params[:year]
    @genre = params[:genre]
  end

  def to_s
    "#{@director} - #{@title} (#{genre}, #{@year} год)"
  end
end
