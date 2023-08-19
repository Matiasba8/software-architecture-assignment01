defmodule Assignment01.SaleContextTest do
  use Assignment01.DataCase

  alias Assignment01.SaleContext

  describe "sales" do
    alias Assignment01.SaleContext.Sale

    import Assignment01.SaleContextFixtures

    @invalid_attrs %{date_of_sale: nil, quantity_sold: nil}

    test "list_sales/0 returns all sales" do
      sale = sale_fixture()
      assert SaleContext.list_sales() == [sale]
    end

    test "get_sale!/1 returns the sale with given id" do
      sale = sale_fixture()
      assert SaleContext.get_sale!(sale.id) == sale
    end

    test "create_sale/1 with valid data creates a sale" do
      valid_attrs = %{date_of_sale: ~D[2023-08-05], quantity_sold: 42}

      assert {:ok, %Sale{} = sale} = SaleContext.create_sale(valid_attrs)
      assert sale.date_of_sale == ~D[2023-08-05]
      assert sale.quantity_sold == 42
    end

    test "create_sale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SaleContext.create_sale(@invalid_attrs)
    end

    test "update_sale/2 with valid data updates the sale" do
      sale = sale_fixture()
      update_attrs = %{date_of_sale: ~D[2023-08-06], quantity_sold: 43}

      assert {:ok, %Sale{} = sale} = SaleContext.update_sale(sale, update_attrs)
      assert sale.date_of_sale == ~D[2023-08-06]
      assert sale.quantity_sold == 43
    end

    test "update_sale/2 with invalid data returns error changeset" do
      sale = sale_fixture()
      assert {:error, %Ecto.Changeset{}} = SaleContext.update_sale(sale, @invalid_attrs)
      assert sale == SaleContext.get_sale!(sale.id)
    end

    test "delete_sale/1 deletes the sale" do
      sale = sale_fixture()
      assert {:ok, %Sale{}} = SaleContext.delete_sale(sale)
      assert_raise Ecto.NoResultsError, fn -> SaleContext.get_sale!(sale.id) end
    end

    test "change_sale/1 returns a sale changeset" do
      sale = sale_fixture()
      assert %Ecto.Changeset{} = SaleContext.change_sale(sale)
    end
  end
end
