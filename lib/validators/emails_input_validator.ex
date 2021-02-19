defmodule Validators.EmailsInputValidator do
  def validate(emails) do
    if emails |> Enum.empty?() do
      raise ArgumentError, message: "Oops! It seems your emails list is empty. Put some email(s) into it and try again"
    end

    emails
  end
end
