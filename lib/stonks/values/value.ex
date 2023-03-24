defmodule Stonks.Values.Value do
  use Ecto.Schema
  import Ecto.Changeset

  schema "values" do
    field :date, :date
    field :value, :float

    belongs_to :currency, Stonks.Currencies.Currency

    timestamps()
  end

  @doc false
  def changeset(value, attrs) do
    value
    |> cast(attrs, [:currency_id, :date, :value])
    |> validate_required([:currency_id, :date, :value])
  end
end
