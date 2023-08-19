defmodule Assignment01.SaleContext.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    belongs_to :book, Assignment01.BookContext.Book
    field :date_of_sale, :date
    field :quantity_sold, :integer

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:date_of_sale, :quantity_sold, :book_id])
    |> validate_required([:date_of_sale, :quantity_sold, :book_id])
  end
end
