defmodule Elixir2pdf.Mixfile do
  use Mix.Project

  def project do
    [
     app: :elixir2pdf,
     version: "0.0.1",
     elixir: "~> 1.2",
     name: "Elixir2pdf",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps,
     docs: [
            main: "readme", 
            extras: ["README.md", "COLORS.md", "FONTS.md", "CHANGELOG.md"]
           ] 
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:erlguten, github: "kennellroxco/erlguten"},
      {:ex_doc, github: "elixir-lang/ex_doc", only: :dev},
      {:earmark, github: "pragdave/earmark", override: true, only: :dev}
    ]
  end

  defp description do
    """
    Elixir2pdf is a simple Elixir wrapper for ErlGuten, a Erlang PDF generation application.
    """
  end

  defp package do
    [
      maintainers: ["Jason Kennell"],
      licenses: ["MIT License"],
      links: %{
                "Github" => "https://github.com/kennellroxco/elixir2pdf",
                "Changelog" => "https://github.com/kennellroxco/elixir2pdf/blob/master/COLORS.md"
               }
    ]
  end
end
