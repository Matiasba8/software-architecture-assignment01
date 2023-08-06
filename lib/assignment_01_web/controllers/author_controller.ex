defmodule Assignment01Web.AuthorController do
  use Assignment01Web, :controller

  alias Assignment01.AuthorContext
  alias Assignment01.AuthorContext.Author

  def index(conn, _params) do
    authors = AuthorContext.list_authors()
    render(conn, :index, authors: authors)
  end

  def new(conn, _params) do
    changeset = AuthorContext.change_author(%Author{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case AuthorContext.create_author(author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: ~p"/authors/#{author}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = AuthorContext.get_author!(id)
    render(conn, :show, author: author)
  end

  def edit(conn, %{"id" => id}) do
    author = AuthorContext.get_author!(id)
    changeset = AuthorContext.change_author(author)
    render(conn, :edit, author: author, changeset: changeset)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = AuthorContext.get_author!(id)

    case AuthorContext.update_author(author, author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author updated successfully.")
        |> redirect(to: ~p"/authors/#{author}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, author: author, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = AuthorContext.get_author!(id)
    {:ok, _author} = AuthorContext.delete_author(author)

    conn
    |> put_flash(:info, "Author deleted successfully.")
    |> redirect(to: ~p"/authors")
  end
end
