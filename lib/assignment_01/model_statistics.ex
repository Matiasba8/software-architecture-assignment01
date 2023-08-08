defmodule Assignment01.ModelStatisticContext do

  import Ecto.Query, warn: false
  alias Assignment01.Repo

  alias Assignment01.BookContext.Book
  alias Assignment01.SaleContext.Sale
  alias Assignment01.AuthorContext.Author
  alias Assignment01.ReviewContext.Review

  def list_stats_01_table(description) do

    # book counter query
    books_counter = from author in Author,
                left_join: book in assoc(author, :books),
                select: %{author_id: author.id, author_name: author.name, book_count: count(book.id), book_description: book.summary},
                group_by: [author.id, author.name, book.summary]


    #avg score
    avg_score = from book in Book,
                left_join: review in Review, on: review.book_id == book.id,
                group_by: book.author_id,
                select: %{author_id: book.author_id, avg_score: avg(review.score)}

    #total_Sales
    total_sales = from book in Book,
      left_join: sale in assoc(book, :sales),
      group_by: book.author_id,
      select: %{author_id: book.author_id, total_sales: sum(sale.quantity_sold)}


    # Combine the results
    combined_query = from bc in subquery(books_counter),
      left_join: ts in subquery(total_sales), on: bc.author_id == ts.author_id,
      left_join: as in subquery(avg_score), on: bc.author_id == as.author_id,
      select: %{author_name: bc.author_name, book_count: bc.book_count, avg_score: as.avg_score, total_sales: ts.total_sales, book_description: bc.book_description}

    if description != nil do
      IO.puts("combined query executes")
      combined_query = from cq in subquery(combined_query),
                       where: ilike(cq.book_description, ^"%#{description}%")

    end

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

  def top_50_selling_books do
    #total_Sales
    ts_grouped_by_book =
      from(book in Book,
        left_join: sale in assoc(book, :sales),
        group_by: book.id,
        select: %{
          book_id: book.id,
          author_id: book.author_id,
          total_sales: sum(sale.quantity_sold),
          publication_year: fragment("extract(year from ?)", book.date_of_publication)
        },
        limit: 50)

    #total_Sales
    ts_grouped_by_author = from book in Book,
      left_join: sale in assoc(book, :sales),
      group_by: book.author_id,
      select: %{author_id: book.author_id, total_sales: sum(sale.quantity_sold)}


    combined_query = from tsgb_book in subquery(ts_grouped_by_book),
                      left_join: tsgb_author in subquery(ts_grouped_by_author), on: tsgb_author.author_id == tsgb_book.author_id,
                      select: %{book_id: tsgb_book.book_id, author_id: tsgb_book.author_id, book_sales: tsgb_book.total_sales, publication_year: tsgb_book.publication_year, author_total_sales: tsgb_author.total_sales},
                      order_by: [desc: tsgb_book.total_sales]


    combined_query = Repo.all(combined_query)
    ts_grouped_by_book = Repo.all(ts_grouped_by_book)
    ts_grouped_by_author = Repo.all(ts_grouped_by_author)
    # Repo.all(combined_query)

    IO.puts("---------ts_grouped_by_book---------------")
    IO.inspect(ts_grouped_by_book)
    IO.puts("------------------------")

    IO.puts("---------ts_grouped_by_author---------------")
    IO.inspect(ts_grouped_by_author)
    IO.puts("------------------------")

    IO.puts("---------result---------------")
    IO.inspect(combined_query)
    IO.puts("------------------------")

    IO.puts("*******************")
    IO.inspect(combined_query)
    IO.puts("*******************")

    combined_query
  end

  def top_10_rated_books do
    avg_ratings_query =
      from book in Book,
        left_join: review in assoc(book, :reviews),
        group_by: book.id,
        select: %{book_id: book.id, avg_rating: avg(review.score)}

    top_rated_query =
      from avg_r in subquery(avg_ratings_query),
        left_join: book in Book, on: book.id == avg_r.book_id,
        order_by: [desc: avg_r.avg_rating],
        select: %{book_id: book.id, avg_rating: avg_r.avg_rating, book_name: book.name},
        limit: 10

    top_rated_books = Repo.all(top_rated_query)

    IO.puts("---------Top Rated Books---------------")
    IO.inspect(top_rated_books)
    IO.puts("----------------------------------------")

    top_rated_books
  end
end
