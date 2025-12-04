defmodule AOC.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Test coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "test.watch": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # Auto-run tests on file changes
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      # Pretty test output
      {:ex_unit_notifier, "~> 1.0", only: :test}
    ]
  end
end
