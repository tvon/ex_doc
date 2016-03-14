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

    generate_document(module_nodes)
    Path.join(config.output, "document.tex")
  end

  defp normalize_config(%{main: "index"}) do
    raise ArgumentError, message: ~S("main" cannot be set to "index", otherwise it will recursively link to itself)
  end

  defp normalize_config(%{main: main} = config) do
    %{config | main: main || @main}
  end

  defp generate_document(module_nodes) do
    IO.puts("module_nodes: #{inspect module_nodes}")
    #file_name = "document.latex"
    #config = set_canonical_url(config, file_name)
    #content = Templates.generate(module_nodes)
    #content = Templates.module_page(node, modules, exceptions, protocols, config)
    #File.write!("#{output}/#{file_name}", content)
  end

  defp templates_path(patterns) do
    Enum.into(patterns, [], fn {pattern, dir} ->
      {Path.expand("latex/templates/#{pattern}", __DIR__), dir}
    end)
  end

  # TODO: Not sure what this does exactly
  defp set_canonical_url(config, file_name) do
    if config.canonical do
      canonical_url =
        config.canonical
        |> String.rstrip(?/)
        |> Path.join(file_name)

      Map.put(config, :canonical, canonical_url)
    else
      config
    end
  end
end
