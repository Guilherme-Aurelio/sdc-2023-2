defmodule Poligono do
  @menu "

  Menu do sistema

  =============

  1. Criar
  2. Listar
  3. Atualizar
  4. Excluir
  5. Sair

  Entre com sua opção: "


  def criar(lista) do
    input = IO.gets("")

    case String.trim(input) do
      "" -> lista
      coords ->
        [x, y | _rest] = String.split(coords) |> Enum.map(&String.to_integer/1)
        nova_lista = lista ++ [{x, y}]
        IO.puts("Coordenada criada com sucesso.")
        nova_lista
    end
  end

  def listar(lista) do
    IO.puts("Listar")
    Enum.each(lista, fn {x, y} -> IO.puts("(#{x}, #{y})") end)
    lista
  end

  def alterar(lista) do
    IO.puts("Alterar")
    IO.puts("Digite o par que você deseja alterar (formato: x y):")
    [x, y] = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)

    case Enum.find_index(lista, &(&1 == {x, y})) do
      nil ->
        IO.puts("Par de coordenadas não encontrado.")
        lista
      indice ->
        IO.puts("Digite o novo par de coordenadas (formato: x y):")
        [a, b] = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)

        # Criar uma nova lista com a coordenada atualizada
        nova_lista = List.replace_at(lista, indice, {a, b})
        IO.puts("Coordenada alterada com sucesso.")
        nova_lista
    end
  end

  def excluir(lista) do
    IO.puts("Excluir")
    IO.puts("Digite o par que você deseja excluir (formato: x y):")
    [x, y] = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)

    case Enum.find_index(lista, &(&1 == {x, y})) do
      nil ->
        IO.puts("Par de coordenadas não encontrado.")
        lista
      indice ->
        # Criar uma nova lista excluindo o par de coordenadas
        nova_lista = Enum.reject(lista, fn {a, b} -> a == x and b == y end)
        IO.puts("Coordenada excluída com sucesso.")
        nova_lista
    end
  end

  def principal(lista) do
    loop(lista)
  end

  defp loop(lista) do
    IO.puts("""
      Menu do sistema
      =============
      1. Criar
      2. Listar
      3. Atualizar
      4. Excluir
      5. Sair
      Entre com sua opção:
    """)

    case IO.gets("") |> String.trim() |> String.to_integer() do
      1 ->
        IO.puts("Digite as coordenadas do ponto (x, y), separadas por espaço. Aperte ENTER duas vezes.")
        loop(criar(lista))

      2 ->
        listar(lista)
        loop(lista)

      3 ->
        loop(alterar(lista))

      4 ->
        loop(excluir(lista))

      5 ->
        IO.puts("Até logo")

      _ ->
        IO.puts("Opção inválida")
        loop(lista)
    end
  end
end
