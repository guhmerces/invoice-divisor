defmodule Entities.InvoiceLine do
  alias Entities.InvoiceLine, as: InvoiceLine

  defstruct name: nil, price: 0, qty: 0

  @spec total_price(%InvoiceLine{}) :: integer()

  def total_price(%InvoiceLine{} = invoice_line) do
    invoice_line.price * invoice_line.qty
  end
end
