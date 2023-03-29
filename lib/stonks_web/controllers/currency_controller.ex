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
    currencies = Currencies.list_currencies_with_values()
    render(conn, :show, currency: currency, currencies: currencies)
  end

  def compare_currencies(conn, %{"currency_id" => currency_id, "compare_id" => compare_id}) do
    currency = Currencies.get_currency!(currency_id)
    compare = Currencies.get_currency!(compare_id)

    currency_values = Enum.sort_by(currency.values, &(&1.date), :desc)
    compare_values = Enum.sort_by(compare.values, &(&1.date), :desc)

    currency_date_list = for value <- currency_values, into: [], do: to_string(value.date)
    compare_date_list = for value <- compare_values, into: [], do: to_string(value.date)

    currency_values_list = for value <- currency_values, into: [], do: to_string(value.value)
    compare_values_list = for value <- compare_values, into: [], do: to_string(value.value)

    render(conn, "compare_currencies.html", currency: %{currency | values: currency_values}, compare: %{compare | values: compare_values}, currency_date_list: currency_date_list, compare_date_list: compare_date_list, currency_values_list: currency_values_list, compare_values_list: compare_values_list)
  end

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
