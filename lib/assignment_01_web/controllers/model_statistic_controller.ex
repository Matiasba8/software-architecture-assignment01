defmodule Assignment01Web.ModelStatisticController do
  use Assignment01Web, :controller
  alias Assignment01.ModelStatisticContext


  def index(conn, _params) do
    render(conn, :index)
  end

  def statistics_01(conn, _params) do
    statistic_01_data = ModelStatisticContext.list_stats_01_table(nil)

    render(conn, :index, data: statistic_01_data, action: "/model_statistic/statistics_01_post")
  end

  #POST
  def statistics_01_post(conn, %{"search" => search}) do

    IO.puts("**********Parameters***********")
    IO.puts(search)
    IO.puts("*********************")
    statistic_01_data = ModelStatisticContext.list_stats_01_table(search)

    render(conn, :index, data: statistic_01_data)
  end

  def top_50_selling_books(conn, _params) do

    top_50_selling_books = ModelStatisticContext.top_50_selling_books()

    render(conn, :top_50_selling_books, top_50_selling_books: top_50_selling_books)
  end

  def top_10_rated_books(conn, _params) do

    top_10_rated_books = ModelStatisticContext.top_10_rated_books()

    render(conn, :top_10_rated_books, top_10_rated_books: top_10_rated_books)
  end
end
