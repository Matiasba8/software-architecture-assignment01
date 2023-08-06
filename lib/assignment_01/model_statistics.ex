defmodule Assignment01.ModelStatisticContext do

  import Ecto.Query, warn: false
  alias Assignment01.Repo

  alias Assignment01.BookContext.Book
  alias Assignment01.SaleContext.Sale
  alias Assignment01.AuthorContext.Author
  alias Assignment01.ReviewContext.Review

  def list_stats_01_table do

    # authors_data = from author in Author,
    #             join: book in assoc(author, :books),
    #             select: %{book_id: book.id, author_id: ^author.id, author_name: author.name, book_count: count(book.id)},
    #             group_by: [author.id, author.name]

    # books = from book in Book, select: book.author_id


    # books = Repo.all(books)
    # for book <- books do
    #   IO.puts("Book author id: #{book}")
    # end

    # authors_data = Repo.all(authors_data)


    # for dict <- authors_data do
    #   IO.puts("Author name: #{dict[:name]}")
    # end

    # IO.puts("------------------------")
    # IO.inspect(authors_data)
    # IO.puts("------------------------")


    # authors_data
  end
end
