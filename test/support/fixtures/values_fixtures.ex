defmodule Stonks.ValuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Stonks.Values` context.
  """

  @doc """
  Generate a value.
  """
  def value_fixture(attrs \\ %{}) do
    {:ok, value} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-03-23],
        value: 120.5,
        variation: 120.5,
        variation_percent: 120.5
      })
      |> Stonks.Values.create_value()

    value
  end
end
