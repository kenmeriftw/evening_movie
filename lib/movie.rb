class Movie
  attr_accessor :rank, :title, :director, :year, :genre

  def initialize(params)
    @rank = params[:rank]
    @title = params[:title]
    @director = params[:director]
    @year = params[:year]
    @genre = params[:genre]
  end

  def to_s
    "#{@director} - #{@title} (#{genre}, #{@year} год, #{@rank} место в рейтине IMDb)."
  end
end
