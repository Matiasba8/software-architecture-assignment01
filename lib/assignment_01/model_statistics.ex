defmodule Assignment01.ModelStatisticContext do

  import Ecto.Query, warn: false
  alias Assignment01.Repo

  alias Assignment01.BookContext.Book
  alias Assignment01.SaleContext.Sale
  alias Assignment01.AuthorContext.Author
  alias Assignment01.ReviewContext.Review

  def list_stats_01_table do

    # book counter query
    # authors_data = from author in Author,
    #             join: book in assoc(author, :books),
    #             select: %{author_id: author.id, author_name: author.name, book_count: count(book.id)},
    #             group_by: [author.id, author.name]


    #avg score
    authors_data = from author in Author,
                join: book in assoc(author, :books),
                select: %{author_id: author.id, author_name: author.name }

    #total_Sales

    #Test
    books = from book in Book, select: %{author_id: book.author_id, book_id: book.id}


    books = Repo.all(books)
    for book <- books do
      IO.puts("Book author id: #{book[:author_id]}, book_id: #{book[:book_id]}")
    end

    authors_data = Repo.all(authors_data)


    for dict <- authors_data do
      IO.puts("Author name: #{dict[:name]}")
    end

    IO.puts("---------BOOKS---------------")
    IO.inspect(books)
    IO.puts("------------------------")

    IO.puts("---------BOOKS---------------")
    IO.inspect(authors_data)
    IO.puts("------------------------")

    books
  end
end
