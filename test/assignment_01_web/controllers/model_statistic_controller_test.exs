defmodule Assignment01Web.ModelStatisticControllerTest do
  use Assignment01Web.ConnCase

  import Assignment01.ModelsStatisticsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all models_statistics", %{conn: conn} do
      conn = get(conn, ~p"/models_statistics")
      assert html_response(conn, 200) =~ "Listing Models statistics"
    end
  end

  describe "new model_statistic" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/models_statistics/new")
      assert html_response(conn, 200) =~ "New Model statistic"
    end
  end

  describe "create model_statistic" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/models_statistics", model_statistic: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/models_statistics/#{id}"

      conn = get(conn, ~p"/models_statistics/#{id}")
      assert html_response(conn, 200) =~ "Model statistic #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/models_statistics", model_statistic: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Model statistic"
    end
  end

  describe "edit model_statistic" do
    setup [:create_model_statistic]

    test "renders form for editing chosen model_statistic", %{conn: conn, model_statistic: model_statistic} do
      conn = get(conn, ~p"/models_statistics/#{model_statistic}/edit")
      assert html_response(conn, 200) =~ "Edit Model statistic"
    end
  end

  describe "update model_statistic" do
    setup [:create_model_statistic]

    test "redirects when data is valid", %{conn: conn, model_statistic: model_statistic} do
      conn = put(conn, ~p"/models_statistics/#{model_statistic}", model_statistic: @update_attrs)
      assert redirected_to(conn) == ~p"/models_statistics/#{model_statistic}"

      conn = get(conn, ~p"/models_statistics/#{model_statistic}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, model_statistic: model_statistic} do
      conn = put(conn, ~p"/models_statistics/#{model_statistic}", model_statistic: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Model statistic"
    end
  end

  describe "delete model_statistic" do
    setup [:create_model_statistic]

    test "deletes chosen model_statistic", %{conn: conn, model_statistic: model_statistic} do
      conn = delete(conn, ~p"/models_statistics/#{model_statistic}")
      assert redirected_to(conn) == ~p"/models_statistics"

      assert_error_sent 404, fn ->
        get(conn, ~p"/models_statistics/#{model_statistic}")
      end
    end
  end

  defp create_model_statistic(_) do
    model_statistic = model_statistic_fixture()
    %{model_statistic: model_statistic}
  end
end
