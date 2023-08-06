defmodule Assignment01.BookContext.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :name, :string
    field :summary, :string
    field :date_of_publication, :date
    field :price, :decimal
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :summary, :date_of_publication, :price])
    |> validate_required([:name, :summary, :date_of_publication, :price])
  end
end
