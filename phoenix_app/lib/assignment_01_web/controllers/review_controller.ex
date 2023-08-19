defmodule Assignment01Web.ReviewController do
  use Assignment01Web, :controller

  alias Assignment01.ReviewContext
  alias Assignment01.ReviewContext.Review

  def index(conn, _params) do
    reviews = ReviewContext.list_reviews()
    render(conn, :index, reviews: reviews)
  end

  def new(conn, _params) do
    changeset = ReviewContext.change_review(%Review{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"review" => review_params}) do
    case ReviewContext.create_review(review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = ReviewContext.get_review!(id)
    render(conn, :show, review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = ReviewContext.get_review!(id)
    changeset = ReviewContext.change_review(review)
    render(conn, :edit, review: review, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = ReviewContext.get_review!(id)

    case ReviewContext.update_review(review, review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = ReviewContext.get_review!(id)
    {:ok, _review} = ReviewContext.delete_review(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: ~p"/reviews")
  end
end
