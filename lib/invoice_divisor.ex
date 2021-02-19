defmodule InvoiceDivisor do
  @moduledoc """
  Documentation for `InvoiceDivisor`.
  """

  @doc """
  This module is responsible for make the most egalitarian possible division of a total invoice value by the numbers of emails received.
  The last emails always receive the remaining cents from invoice division result.

  ## Examples
      iex> products_list = [
        %{
          name: "RTX 2080 T.I",
          price: 546183,
          qty: 2,
        },
        %{
          name: "Intel Core i7",
          price: 161245,
          qty: 1,
        }
      ]
      emails = [
          "foo@email.com",
          "bar@email.com",
          "hello@email.com",
          "world@email.com"
      ]
      products_list |> InvoiceDivisor.per_user(emails)

      Output:
      [
        %{"foo@email.com": 313402},
        %{"bar@email.com": 313403},
        %{"hello@email.com": 313403},
        %{"world@email.com": 313403}
      ]
  """

  alias Validators.ProductsInputValidator, as: ProductsInputValidator
  alias Validators.EmailsInputValidator, as: EmailsInputValidator
  alias InvoicePerUserCalculator
  alias Entities.User, as: User

  def per_user(products, emails) do
    users =
      emails
      |> EmailsInputValidator.validate()
      |> Enum.map(fn email ->
        %User{
          email: email
        }
      end)

    products
    |> ProductsInputValidator.validate()
    |> ProductsInputValidator.to_domain()
    |> InvoicePerUserCalculator.execute(users)
    |> format_group_response
  end

  def format_group_response(list) do
    list
    |> Enum.map(fn list ->
      %{"#{list.email}": list.cost}
    end)
  end
end
