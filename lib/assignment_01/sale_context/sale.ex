defmodule Assignment01.SaleContext.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :date_of_sale, :date
    field :quantity_sold, :integer
    field :book_id, :id

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:date_of_sale, :quantity_sold])
    |> validate_required([:date_of_sale, :quantity_sold])
  end
end
