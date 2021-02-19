defmodule Validators.ProductsInputValidator do
  def validate(products) do
    if products |> Enum.empty?() do
      raise ArgumentError,
        message:
          "Oops! It seems your products list is empty. Put some product(s) data into it and try again"
    end

    products
  end
end
