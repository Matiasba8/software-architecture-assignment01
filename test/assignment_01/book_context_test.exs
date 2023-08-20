defmodule Assignment01.BookContextTest do
  use Assignment01.DataCase

  alias Assignment01.BookContext

  describe "books" do
    alias Assignment01.BookContext.Book

    import Assignment01.BookContextFixtures

    @invalid_attrs %{name: nil, summary: nil, date_of_publication: nil, price: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert BookContext.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert BookContext.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{name: "some name", summary: "some summary", date_of_publication: ~D[2023-08-05], price: "120.5"}

      assert {:ok, %Book{} = book} = BookContext.create_book(valid_attrs)
      assert book.name == "some name"
      assert book.summary == "some summary"
      assert book.date_of_publication == ~D[2023-08-05]
      assert book.price == Decimal.new("120.5")
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookContext.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{name: "some updated name", summary: "some updated summary", date_of_publication: ~D[2023-08-06], price: "456.7"}

      assert {:ok, %Book{} = book} = BookContext.update_book(book, update_attrs)
      assert book.name == "some updated name"
      assert book.summary == "some updated summary"
      assert book.date_of_publication == ~D[2023-08-06]
      assert book.price == Decimal.new("456.7")
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = BookContext.update_book(book, @invalid_attrs)
      assert book == BookContext.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = BookContext.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> BookContext.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = BookContext.change_book(book)
    end
  end
end
