defmodule Stonks.Repo.Migrations.AlterValuesTable do
  use Ecto.Migration

  def change do
      alter table(:values) do
        remove :variation
        remove :variation_percent
      end
  end
end
