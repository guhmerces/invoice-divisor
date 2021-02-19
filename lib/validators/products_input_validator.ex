defmodule Validators.ProductsInputValidator do
  alias Entities.InvoiceLine, as: InvoiceLine

  def validate(products) do
    if products |> Enum.empty?() do
      raise ArgumentError,
        message:
          "Oops! It seems your products list is empty. Put some product(s) data into it and try again"
    end

    products
  end

  def to_domain(products_data) do
    products_data
    |> Enum.map(fn product_data ->
      %InvoiceLine{
        name: product_data[:name],
        price: product_data[:price],
        qty: product_data[:qty]
      }
    end)
  end
end
