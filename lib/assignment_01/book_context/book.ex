defmodule Assignment01.BookContext.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    has_many :reviews, Assignment01.ReviewContext.Review
    has_many :sales, Assignment01.SaleContext.Sale
    belongs_to :author, Assignment01.AuthorContext.Author


    field :name, :string
    field :summary, :string
    field :date_of_publication, :date
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :summary, :date_of_publication, :price, :author_id])
    |> validate_required([:name, :summary, :date_of_publication, :price, :author_id])
  end
end
