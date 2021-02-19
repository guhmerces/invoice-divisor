defmodule Entities.Invoice do
  alias Entities.InvoiceLine, as: InvoiceLine

  @spec total_value([%InvoiceLine{}]) :: integer()

  def total_value(invoice_line_list) do
    invoice_line_list
    |> Enum.map(fn invoice_line ->
      invoice_line
      |> InvoiceLine.total_price()
    end)
    |> Enum.sum()
  end
end
