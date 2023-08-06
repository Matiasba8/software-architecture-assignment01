defmodule Assignment01.ReviewContext.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :review, :string
    field :score, :integer
    field :number_of_upvotes, :integer
    field :book_id, :id

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:review, :score, :number_of_upvotes])
    |> validate_required([:review, :score, :number_of_upvotes])
  end
end
