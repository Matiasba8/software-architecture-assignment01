defmodule Assignment01.AuthorContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Assignment01.AuthorContext` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        name: "some name",
        date_of_birth: ~D[2023-08-04],
        country_of_origin: "some country_of_origin",
        short_description: "some short_description"
      })
      |> Assignment01.AuthorContext.create_author()

    author
  end
end
