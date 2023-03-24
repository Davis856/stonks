defmodule Stonks.CurrenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Stonks.Currencies` context.
  """

  @doc """
  Generate a unique currency name.
  """
  def unique_currency_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: unique_currency_name()
      })
      |> Stonks.Currencies.create_currency()

    currency
  end
end
