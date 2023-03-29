defmodule StonksWeb.CurrencyHTML do
  use StonksWeb, :html

  embed_templates "currency_html/*"

  @doc """
  Renders a currency form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def currency_form(assigns)

  def transform_currency_values(currency, compare) do
    first_valid_row = Enum.find(currency.values, fn value ->
      compare_value = Enum.find(compare.values, fn compare_value -> compare_value.date == value.date end)
      compare_value != nil
    end)

    last_ratio = if first_valid_row != nil do
      Enum.find(compare.values, fn value -> value.date == first_valid_row.date end).value / first_valid_row.value
    else
      0
    end

    Enum.map(currency.values, fn value ->
      compare_value = Enum.find(compare.values, fn compare_value -> compare_value.date == value.date end)

      if compare_value do
        ratio = value.value / compare_value.value
        ratio_variation = if last_ratio != 0 do (ratio - last_ratio) / last_ratio else 0 end
        ratio_variation_percentage = ratio_variation * 100

        %{
          date: value.date,
          value: value.value,
          compare_value: compare_value.value,
          ratio: Float.round(ratio, 4),
          ratio_variation: Float.round(ratio_variation, 4),
          ratio_variation_percentage: Float.round(ratio_variation_percentage, 4)
        }
      end
    end)
  end
end
