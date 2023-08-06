defmodule Assignment01.SaleContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Assignment01.SaleContext` context.
  """

  @doc """
  Generate a sale.
  """
  def sale_fixture(attrs \\ %{}) do
    {:ok, sale} =
      attrs
      |> Enum.into(%{
        date_of_sale: ~D[2023-08-05],
        quantity_sold: 42
      })
      |> Assignment01.SaleContext.create_sale()

    sale
  end
end
