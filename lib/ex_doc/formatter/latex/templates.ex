defmodule ExDoc.Formatter.Latex.Templates do

  require EEx

  def generate(module_nodes) do
    filename = Path.expand("templates/document.tex.eex", __DIR__)
    # EEx.function_from_file :def, name, filename, args
  end

  # NOTE: Only cmark supports this, require cmark parser?
  defp to_latex(bin) do: ExDoc.Markdown.to_latex(bin)

end
