defmodule Assignment01.BookContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Assignment01.BookContext` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        name: "some name",
        summary: "some summary",
        date_of_publication: ~D[2023-08-05],
        price: "120.5"
      })
      |> Assignment01.BookContext.create_book()

    book
  end
end
