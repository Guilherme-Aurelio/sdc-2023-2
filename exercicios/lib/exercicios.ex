defmodule Exercicios do
def q1 do
  IO.puts("Olá mundo!")
end

def q2 do
  IO.puts("Digite seu nome:")
  nome = IO.gets("") |> String.trim()
  IO.puts("Olá #{nome}!")
end

def q3 do
  IO.puts("Digite seu nome:")
  nome_idade = IO.gets("") |> String.trim()

  IO.puts("Digite seu ano de nascimento:")
  ano_nascimento = IO.gets("") |> String.trim() |> String.to_integer()

  ano_atual = DateTime.utc_now().year
  idade = ano_atual - ano_nascimento

  IO.puts("Olá #{nome_idade}, você tem #{idade} anos.")
end

def q4 do
  IO.puts("Digite seu nome:")
  nome_imc = IO.gets("") |> String.trim()

  IO.puts("Digite seu peso em Kg:")
  peso = IO.gets("") |> String.trim() |> String.to_float()

  IO.puts("Digite sua altura em centímetros:")
  altura_cm = IO.gets("") |> String.trim() |> String.to_float()

  altura_m = altura_cm / 100
  imc = peso / (altura_m * altura_m)

  IO.puts("Olá #{nome_imc}, seu IMC é de #{imc}.")
end

def q5 do
  IO.puts("Digite a quantidade de números:")
  n = IO.gets("") |> String.trim() |> String.to_integer()

  lista_numeros = Enum.map(1..n, fn _ ->
    IO.puts("Digite um número:")
    IO.gets("") |> String.trim() |> String.to_integer()
  end)

  IO.puts("A sequência inversa é:")
  Enum.reverse(lista_numeros) |> IO.inspect()
end

def q6 do
  IO.puts("Digite a quantidade de pares matrícula/nome:")
  n_pares = IO.gets("") |> String.trim() |> String.to_integer()

  pares = Enum.reduce(1..n_pares, %{}, fn _, acc ->
    IO.puts("Digite a matrícula:")
    matricula = IO.gets("") |> String.trim()

    IO.puts("Digite o nome:")
    nome_aluno = IO.gets("") |> String.trim()

    Map.put(acc, matricula, nome_aluno)
  end)

  IO.puts("Dicionário de matrícula/nome:")
  IO.inspect(pares)
end
end
