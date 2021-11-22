# InvoiceDivisor 

This small application makes the most egalitarian possible division of an invoice value for the emails received.

For my first week learning Elixir, I thought it was a great idea to start with this challenge I found. Before anything, it was very fun and a opportunity to learn a little about this eloquent language.

## Considerations

The application receives a list of Maps of products and a list of emails.
The last emails always receive the remaining cents from the invoice division result.

## Installation

 1. Install Elixir and Erlang in case you haven't (this projects contains a .tool-version file and if you have asdf installed you can just run `asdf install` at the root of this project).
 3. Run `mix` to Invokes the default task (mix run) in a project.
 4. Run `iex -S mix` to use IEx with Mix

## Running the app

First, create a list of Maps that represents products containing their respectives names, quantities and prices. See the example above:

```elixir
iex> products_list = [
      %{
        name: "RTX 2080 T.I",
        price: 546183,
        qty: 2
      },
      %{
        name: "Intel Core i7",
        price: 161245,
        qty: 1
      }
    ]
```

Now, you should create a list of emails:

```elixir
iex> emails = [
          "foo@example.com",
          "bar@example.com",
          "hello@example.com",
          "world@example.com"
      ]
```

To get the result, call the function like above:

```elixir
iex> products_list |> InvoiceDivisor.per_user(emails)
```

The output for this exemple:
```elixir
    [
        %{"foo@email.com": 313402},
        %{"bar@email.com": 313403},
        %{"hello@email.com": 313403},
        %{"world@email.com": 313403}
    ]
```
