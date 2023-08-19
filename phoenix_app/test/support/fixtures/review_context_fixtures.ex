defmodule Assignment01.ReviewContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Assignment01.ReviewContext` context.
  """

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        review: "some review",
        score: 42,
        number_of_upvotes: 42
      })
      |> Assignment01.ReviewContext.create_review()

    review
  end
end
