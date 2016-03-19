defmodule ExDoc.Formatter.Latex.Templates do

  require EEx

  templates = [
    document: [:config, :module_nodes],
    type_node: [:type_node],
    module_node: [:module_node],
    function_node: [:function_node]
  ]

  Enum.each templates, fn({name, args}) ->
    filename = Path.expand("templates/#{name}.tex.eex", __DIR__)
    @doc false
    EEx.function_from_file(:def, name, filename, args)
  end

  # FIXME: Only cmark supports this, require cmark parser?
  # FIXME: Requires adding method to Markdown processor.
  defp to_latex(bin) do
    ExDoc.Markdown.to_latex(bin)
  end

  defp subsectionize(str) do
    String.replace(str, "section", "subsection")
  end

  defp escape(s) do
    mapping = %{
      '#' => "\\#",
      '$' => "\\$",
      '%' => "\\%",
      '&' => "\\&",
      '\\' => "\\textbackslash{}",
      '^' => "\\textasciicircum{}",
      '_' => "\\_",
      '{' => "\\{",
        '}' => "\\}",
    '~' => "\\textasciitilde{}"
    }
  end

end
