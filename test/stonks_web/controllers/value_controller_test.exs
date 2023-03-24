defmodule StonksWeb.ValueControllerTest do
  use StonksWeb.ConnCase

  import Stonks.ValuesFixtures

  @create_attrs %{date: ~D[2023-03-23], value: 120.5, variation: 120.5, variation_percent: 120.5}
  @update_attrs %{date: ~D[2023-03-24], value: 456.7, variation: 456.7, variation_percent: 456.7}
  @invalid_attrs %{date: nil, value: nil, variation: nil, variation_percent: nil}

  describe "index" do
    test "lists all values", %{conn: conn} do
      conn = get(conn, ~p"/values")
      assert html_response(conn, 200) =~ "Listing Values"
    end
  end

  describe "new value" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/values/new")
      assert html_response(conn, 200) =~ "New Value"
    end
  end

  describe "create value" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/values", value: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/values/#{id}"

      conn = get(conn, ~p"/values/#{id}")
      assert html_response(conn, 200) =~ "Value #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/values", value: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Value"
    end
  end

  describe "edit value" do
    setup [:create_value]

    test "renders form for editing chosen value", %{conn: conn, value: value} do
      conn = get(conn, ~p"/values/#{value}/edit")
      assert html_response(conn, 200) =~ "Edit Value"
    end
  end

  describe "update value" do
    setup [:create_value]

    test "redirects when data is valid", %{conn: conn, value: value} do
      conn = put(conn, ~p"/values/#{value}", value: @update_attrs)
      assert redirected_to(conn) == ~p"/values/#{value}"

      conn = get(conn, ~p"/values/#{value}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, value: value} do
      conn = put(conn, ~p"/values/#{value}", value: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Value"
    end
  end

  describe "delete value" do
    setup [:create_value]

    test "deletes chosen value", %{conn: conn, value: value} do
      conn = delete(conn, ~p"/values/#{value}")
      assert redirected_to(conn) == ~p"/values"

      assert_error_sent 404, fn ->
        get(conn, ~p"/values/#{value}")
      end
    end
  end

  defp create_value(_) do
    value = value_fixture()
    %{value: value}
  end
end
