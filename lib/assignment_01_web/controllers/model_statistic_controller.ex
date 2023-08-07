defmodule Assignment01Web.ModelStatisticController do
  use Assignment01Web, :controller
  alias Assignment01.ModelStatisticContext

  alias Assignment01.Repo

  alias Assignment01.BookContext.Book
  alias Assignment01.SaleContext.Sale
  alias Assignment01.AuthorContext.Author
  alias Assignment01.ReviewContext.Review

  def index(conn, _params) do
    render(conn, :index)
  end

  def statistics_01(conn, _params) do

    authors_data = ModelStatisticContext.list_stats_01_table()

    render(conn, "statistics_01.html")
  end
end
