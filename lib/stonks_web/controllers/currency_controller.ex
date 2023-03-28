defmodule StonksWeb.CurrencyController do
  use StonksWeb, :controller

  alias Stonks.Currencies
  alias Stonks.Currencies.Currency

  def index(conn, _params) do
    currencies = Currencies.list_currencies_with_values()
    render(conn, :index, currencies: currencies)
  end

  def new(conn, _params) do
    changeset = Currencies.change_currency(%Currency{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"currency" => currency_params}) do
    case Currencies.create_currency(currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency created successfully.")
        |> redirect(to: ~p"/currencies/#{currency}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    render(conn, :show, currency: currency)
  end

  # defp transform_data_for_chart(currencies) do
  #   dates = currencies |> hd() |> Map.get(:values) |> Enum.map(& &1.date)
  #   currency_data = currencies |> Enum.map(fn currency ->
  #     [currency.name | Map.get(currency, :values) |> Enum.map(& &1.value)]
  #   end)
  #   [labels: dates, datasets: currency_data] |> Poison.encode()
  # end

  def edit(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    changeset = Currencies.change_currency(currency)
    render(conn, :edit, currency: currency, changeset: changeset)
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = Currencies.get_currency!(id)

    case Currencies.update_currency(currency, currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: ~p"/currencies/#{currency}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    {:ok, _currency} = Currencies.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: ~p"/currencies")
  end

end
