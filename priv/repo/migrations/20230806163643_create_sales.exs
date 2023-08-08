defmodule Assignment01.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :date_of_sale, :date
      add :quantity_sold, :integer
      add :book_id, references(:books, on_delete: :delete_all)

      timestamps()
    end

    create index(:sales, [:book_id])
  end
end
