defmodule Stonks.ValuesTest do
  use Stonks.DataCase

  alias Stonks.Values

  describe "values" do
    alias Stonks.Values.Value

    import Stonks.ValuesFixtures

    @invalid_attrs %{date: nil, value: nil, variation: nil, variation_percent: nil}

    test "list_values/0 returns all values" do
      value = value_fixture()
      assert Values.list_values() == [value]
    end

    test "get_value!/1 returns the value with given id" do
      value = value_fixture()
      assert Values.get_value!(value.id) == value
    end

    test "create_value/1 with valid data creates a value" do
      valid_attrs = %{date: ~D[2023-03-23], value: 120.5, variation: 120.5, variation_percent: 120.5}

      assert {:ok, %Value{} = value} = Values.create_value(valid_attrs)
      assert value.date == ~D[2023-03-23]
      assert value.value == 120.5
      assert value.variation == 120.5
      assert value.variation_percent == 120.5
    end

    test "create_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Values.create_value(@invalid_attrs)
    end

    test "update_value/2 with valid data updates the value" do
      value = value_fixture()
      update_attrs = %{date: ~D[2023-03-24], value: 456.7, variation: 456.7, variation_percent: 456.7}

      assert {:ok, %Value{} = value} = Values.update_value(value, update_attrs)
      assert value.date == ~D[2023-03-24]
      assert value.value == 456.7
      assert value.variation == 456.7
      assert value.variation_percent == 456.7
    end

    test "update_value/2 with invalid data returns error changeset" do
      value = value_fixture()
      assert {:error, %Ecto.Changeset{}} = Values.update_value(value, @invalid_attrs)
      assert value == Values.get_value!(value.id)
    end

    test "delete_value/1 deletes the value" do
      value = value_fixture()
      assert {:ok, %Value{}} = Values.delete_value(value)
      assert_raise Ecto.NoResultsError, fn -> Values.get_value!(value.id) end
    end

    test "change_value/1 returns a value changeset" do
      value = value_fixture()
      assert %Ecto.Changeset{} = Values.change_value(value)
    end
  end
end
