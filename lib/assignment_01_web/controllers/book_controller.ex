defmodule Assignment01Web.BookController do
  use Assignment01Web, :controller

  alias Assignment01.BookContext
  alias Assignment01.BookContext.Book

  def index(conn, _params) do
    books = BookContext.list_books()
    render(conn, :index, books: books)
  end

  def new(conn, _params) do
    changeset = BookContext.change_book(%Book{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case BookContext.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: ~p"/books/#{book}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = BookContext.get_book!(id)
    render(conn, :show, book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = BookContext.get_book!(id)
    changeset = BookContext.change_book(book)
    render(conn, :edit, book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = BookContext.get_book!(id)

    case BookContext.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: ~p"/books/#{book}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = BookContext.get_book!(id)
    {:ok, _book} = BookContext.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: ~p"/books")
  end
end
