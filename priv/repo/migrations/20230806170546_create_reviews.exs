defmodule Assignment01.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :review, :string
      add :score, :integer
      add :number_of_upvotes, :integer
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:book_id])
  end
end
