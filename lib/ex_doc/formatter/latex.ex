defmodule ExDoc.Formatter.Latex do
  @moduledoc """
  Generate LaTeX documentation for Elixir projects
  """

  alias ExDoc.Formatter.Latex.Templates

  @doc """
  Generate Latex documentation for the given modules
  """
  @spec run(list, %ExDoc.Config{}) :: String.t
  def run(module_nodes, config) when is_map(config) do
    config = normalize_config(config)
    output = Path.expand(config.output)
    File.rm_rf! output
    :ok = File.mkdir_p output

    generate_document(module_nodes, output, config)
    Path.join(config.output, "document.tex")
  end

  ## private

  defp generate_document(module_nodes, output, config) do
    content = Templates.document(config, module_nodes)
    File.write!("#{output}/document.tex", content)
  end

  defp normalize_config(%{main: "index"}) do
    raise ArgumentError, message: ~S("main" cannot be set to "index", otherwise it will recursively link to itself)
  end

  defp normalize_config(%{main: main} = config) do
    %{config | main: main || @main}
  end

  defp templates_path(patterns) do
    Enum.into(patterns, [], fn {pattern, dir} ->
      {Path.expand("latex/templates/#{pattern}", __DIR__), dir}
    end)
  end
end
