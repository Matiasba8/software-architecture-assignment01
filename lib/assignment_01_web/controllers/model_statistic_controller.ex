defmodule Assignment01Web.ModelStatisticController do
  use Assignment01Web, :controller
  alias Assignment01.ModelStatisticContext

  def index(conn, _params) do
    render(conn, :index)
  end

  def statistics_01(conn, _params) do

    authors_data = ModelStatisticContext.list_stats_01_table()

    render(conn, "statistics_01.html")
  end
end
