defmodule StonksWeb.ValueHTML do
  use StonksWeb, :html

  embed_templates "value_html/*"

  @doc """
  Renders a value form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def value_form(assigns)
end
