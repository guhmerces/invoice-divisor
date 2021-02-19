defmodule InvoicePerUserCalculator do
  alias Entities.Invoice, as: Invoice
  alias Entities.InvoiceLine, as: InvoiceLine
  alias Entities.User, as: User

  @type email_and_cost :: %{
          email: String.t(),
          cost: integer
        }

  @spec execute(
          [%InvoiceLine{}],
          [%User{}]
        ) :: [email_and_cost]

  def execute(invoice_line_list, user_list) do
    total_price = invoice_line_list |> Invoice.total_value()

    total_users = user_list |> Enum.count()

    rounded_value_by_user = (total_price / total_users) |> Kernel.trunc()

    remaining_cents = rem(total_price, total_users)

    payment_groups =
      user_list
      |> to_email_and_cost(rounded_value_by_user)
      |> split_into_payment_groups(remaining_cents)

    group_to_pay_more =
      payment_groups
      |> Enum.at(1)
      |> add_cents_to_cost(1)

    group_to_pay_less =
      payment_groups
      |> Enum.at(0)

    group_to_pay_less ++ group_to_pay_more
  end

  @spec to_email_and_cost(
          [%User{}],
          integer
        ) :: [email_and_cost]

  def to_email_and_cost(user_list, rounded_value) do
    user_list
    |> Enum.map(fn user ->
      %{email: user.email, cost: rounded_value}
    end)
  end

  @spec split_into_payment_groups(
          [email_and_cost],
          integer
        ) :: [email_and_cost]

  def split_into_payment_groups(list, count) do
    case list |> Enum.count() do
      1 ->
        list
        |> Enum.split(count * -1)
        |> Tuple.to_list()
        |> Enum.reverse()

      _ ->
        list
        |> Enum.split(count * -1)
        |> Tuple.to_list()
    end
  end

  @spec add_cents_to_cost(
          [email_and_cost],
          integer
        ) :: [email_and_cost]

  def add_cents_to_cost(list, add) do
    list
    |> Enum.map(fn list ->
      %{list | cost: list.cost + add}
    end)
  end
end
