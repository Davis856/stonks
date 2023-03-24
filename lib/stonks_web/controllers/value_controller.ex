defmodule StonksWeb.ValueController do
  use StonksWeb, :controller

  alias Stonks.Values
  alias Stonks.Values.Value

  def index(conn, %{"currency_id" => currency_id}) do
    values = Values.list_values()
    render(conn, :index, values: values, currency_id: currency_id)
  end

  def new(conn, %{"currency_id" => currency_id}) do
    changeset = Values.change_value(%Value{})
    render(conn, :new, changeset: changeset, currency_id: currency_id)
  end

  def create(conn, %{"value" => value_params, "currency_id" => currency_id}) do
    case Values.create_value(value_params) do
      {:ok, value} ->
        conn
        |> put_flash(:info, "Value created successfully.")
        |> redirect(to: ~p"/currencies/#{currency_id}/values/#{value.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, currency_id: currency_id)
    end
  end

  def show(conn, %{"id" => id, "currency_id" => currency_id}) do
    value = Values.get_value!(id)
    render(conn, :show, value: value, currency_id: currency_id)
  end

  def edit(conn, %{"id" => id, "currency_id" => currency_id}) do
    value = Values.get_value!(id)
    changeset = Values.change_value(value)
    render(conn, :edit, value: value, changeset: changeset, currency_id: currency_id)
  end

  def update(conn, %{"id" => id, "value" => value_params, "currency_id" => currency_id}) do
    value = Values.get_value!(id)

    case Values.update_value(value, value_params) do
      {:ok, value} ->
        conn
        |> put_flash(:info, "Value updated successfully.")
        |> redirect(to: ~p"/currencies/#{currency_id}/values/#{value}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, value: value, changeset: changeset, currency_id: currency_id)
    end
  end

  def delete(conn, %{"id" => id, "currency_id" => currency_id}) do
    value = Values.get_value!(id)
    {:ok, _value} = Values.delete_value(value)

    conn
    |> put_flash(:info, "Value deleted successfully.")
    |> redirect(to: ~p"/currencies/#{currency_id}/values")
  end
end
