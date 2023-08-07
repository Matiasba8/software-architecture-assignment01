defmodule Assignment01.ModelStatisticContext do

  import Ecto.Query, warn: false
  alias Assignment01.Repo

  alias Assignment01.BookContext.Book
  alias Assignment01.SaleContext.Sale
  alias Assignment01.AuthorContext.Author
  alias Assignment01.ReviewContext.Review

  def list_stats_01_table do

    # book counter query
    books_counter = from author in Author,
                left_join: book in assoc(author, :books),
                select: %{author_id: author.id, author_name: author.name, book_count: count(book.id)},
                group_by: [author.id, author.name]


    #avg score
    avg_score = from book in Book,
                left_join: review in Review, on: review.book_id == book.id,
                group_by: book.author_id,
                select: %{author_id: book.author_id, avg_score: avg(review.score)}

    #total_Sales
    total_sales = from book in Book,
      left_join: sale in assoc(book, :sales),
      group_by: book.author_id,
      select: %{author_id: book.author_id, total_sales: sum(sale.quantity_sold * book.price)}


    # Combine the results
    combined_query = from bc in subquery(books_counter),
      left_join: ts in subquery(total_sales), on: bc.author_id == ts.author_id,
      left_join: as in subquery(avg_score), on: bc.author_id == as.author_id,
      select: %{author_name: bc.author_name, book_count: bc.book_count, avg_score: as.avg_score, total_sales: ts.total_sales}

    results = Repo.all(combined_query)
    books_counter = Repo.all(books_counter)
    avg_score = Repo.all(avg_score)
    total_sales = Repo.all(total_sales)

    IO.puts("---------Books counter---------------")
    IO.inspect(books_counter)
    IO.puts("------------------------")


    IO.puts("---------avg_score---------------")
    IO.inspect(avg_score)
    IO.puts("------------------------")


    IO.puts("---------total_sales---------------")
    IO.inspect(total_sales)
    IO.puts("------------------------")


    IO.puts("---------RESULT---------------")
    IO.inspect(results)
    IO.puts("------------------------")

    results
  end
end
