defmodule Stonks.Currencies.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currencies" do
    field :description, :string
    field :name, :string

    has_many :values, Stonks.Values.Value

    timestamps()
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:name, :description, :values_id])
    |> validate_required([:name, :description, :values_id])
    |> unique_constraint(:name)
  end
end
