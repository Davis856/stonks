defmodule Stonks.Repo.Migrations.AlterValuesTable2 do
  use Ecto.Migration

  def change do
    alter table(:values) do
      modify :currency_id, references(:currencies, on_delete: :delete_all), from: references(:currencies, on_delete: :nothing)
    end
  end
end
