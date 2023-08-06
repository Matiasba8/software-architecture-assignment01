defmodule Assignment01.ReviewContextTest do
  use Assignment01.DataCase

  alias Assignment01.ReviewContext

  describe "reviews" do
    alias Assignment01.ReviewContext.Review

    import Assignment01.ReviewContextFixtures

    @invalid_attrs %{review: nil, score: nil, number_of_upvotes: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert ReviewContext.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert ReviewContext.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{review: "some review", score: 42, number_of_upvotes: 42}

      assert {:ok, %Review{} = review} = ReviewContext.create_review(valid_attrs)
      assert review.review == "some review"
      assert review.score == 42
      assert review.number_of_upvotes == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ReviewContext.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{review: "some updated review", score: 43, number_of_upvotes: 43}

      assert {:ok, %Review{} = review} = ReviewContext.update_review(review, update_attrs)
      assert review.review == "some updated review"
      assert review.score == 43
      assert review.number_of_upvotes == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = ReviewContext.update_review(review, @invalid_attrs)
      assert review == ReviewContext.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = ReviewContext.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> ReviewContext.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = ReviewContext.change_review(review)
    end
  end
end
