# Advent of Code 2025 - Elixir Solutions

Solutions for [Advent of Code 2025](https://adventofcode.com/2025) written in Elixir.

## Setup

This project uses Nix flakes for reproducible development environments.

### Enter the development environment

```bash
nix develop
```

### Install dependencies

```bash
mix deps.get
```

## Running Tests

### Run all tests
```bash
mix test
```

### Run tests for a specific day
```bash
mix test test/day01_test.exs
```

### Auto-run tests on file changes
```bash
mix test.watch
```

### Skip puzzle input tests (faster during development)
```bash
mix test --exclude puzzle_input
```

## Workflow for Each Day

### Creating a New Day

Use the custom Mix task to generate all files for a new day:

```bash
mix aoc.new <day_number>
```

For example:
```bash
mix aoc.new 5
```

This will create:
- `lib/day05.ex` - Solution module with template
- `test/day05_test.exs` - Test file with example and puzzle input tests
- `inputs/day05.txt` - Empty input file for your puzzle data

### Solving the Puzzle

1. Add your puzzle input to `inputs/dayXX.txt`
2. Start test watcher: `mix test.watch test/dayXX_test.exs`
3. Fill in the example input and expected result in the test file
4. Implement the solution using TDD
5. Run against the full puzzle input

## Tips

- Use `@tag :puzzle_input` to mark tests that use the actual puzzle input
- Keep example inputs in the test files as module attributes
- Use `IO.puts` in tests to print results for puzzle submission
- The test watcher will automatically rerun tests when you save files

## Development Tools

- `mix aoc.new <day>` - Create template files for a new day
- `mix format` - Format code
- `mix test` - Run tests
- `mix test.watch` - Auto-run tests on file changes
- `iex -S mix` - Start interactive Elixir shell with project loaded
