defmodule ExDoc.Markdown.Cmark do
  @moduledoc """
  ExDoc extension for the Cmark Markdown parser
  """

  @doc """
  Check if the Cmark Markdown parser module is available. Otherwise, try to
  load the module
  """
  def available? do
    Code.ensure_loaded?(Cmark)
  end

  @doc """
  Generate HTML output. Cmark takes no options.
  """
  def to_html(text, _opts) do
    Cmark.to_html(text)
  end

  @doc """
  Generate LaTeX output. Cmark takes no options.
  """
  def to_latex(text, _opts \\ []) do
    Cmark.to_latex(text)
  end
end
