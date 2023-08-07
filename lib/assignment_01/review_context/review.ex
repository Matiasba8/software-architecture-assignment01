defmodule Assignment01.ReviewContext.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    belongs_to :book, Assignment01.BookContext.Book
    field :review, :string
    field :score, :integer
    field :number_of_upvotes, :integer

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:review, :score, :number_of_upvotes, :book_id])
    |> validate_required([:review, :score, :number_of_upvotes, :book_id])
  end
end
