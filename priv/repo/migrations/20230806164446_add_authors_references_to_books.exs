defmodule Assignment01.Repo.Migrations.AddAuthorsReferencesToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :author_id, references(:authors, on_delete: :nothing)
    end
  end
end
