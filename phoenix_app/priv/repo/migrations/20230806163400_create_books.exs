defmodule Assignment01.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :summary, :string
      add :date_of_publication, :date
      add :price, :decimal
      add :author_id, references(:authors, on_delete: :delete_all)

      timestamps()
    end

    create index(:books, [:author_id])
  end
end
