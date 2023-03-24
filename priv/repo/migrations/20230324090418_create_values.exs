defmodule Stonks.Repo.Migrations.CreateValues do
  use Ecto.Migration

  def change do
    create table(:values) do
      add :date, :date
      add :value, :float
      add :variation, :float
      add :variation_percent, :float
      add :currency_id, references(:currencies, on_delete: :nothing)

      timestamps()
    end

    create index(:values, [:currency_id])
  end
end
