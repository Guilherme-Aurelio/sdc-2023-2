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
    criar_pares(lista)
  end

  defp criar_pares(lista) do
    input = IO.gets("Digite as coordenadas do ponto (x, y), separadas por espaço. Coloque um PAR de cada vez. Para sair aperte ENTER.\n")

    case String.trim(input) do
      "" -> lista
      coords ->
        [x, y | rest] = String.split(coords) |> Enum.map(&String.to_integer/1)
        nova_lista = lista ++ [{x, y}]
        IO.puts("Coordenada (#{x}, #{y}) criada com sucesso.")
        criar_pares(nova_lista)
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

  def translacao(lista) do
    IO.puts("Translação")
    IO.puts("Digite os valores de translação para x e y (formato: x y):")
    [tx, ty] = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)

    nova_lista = Enum.map(lista, fn {x, y} -> {x + tx, y + ty} end)
    IO.puts("Translação aplicada com sucesso.")
    nova_lista
  end

  def escala(lista) do
    IO.puts("Escala")
    IO.puts("Digite o fator de escala para x e y (formato: x y):")

    input = IO.gets("") |> String.trim()

    [sx_str | sy_str] = String.split(input, " ", trim: true)
    sx = String.to_integer(sx_str)
    sy = String.to_integer(Enum.join(sy_str, " "))

    nova_lista = Enum.map(lista, fn {x, y} -> {x * sx, y * sy} end)
    IO.puts("Escala aplicada com sucesso.")
    nova_lista
  end



  def rotacao(lista) do
    IO.puts("Rotação")
    IO.puts("Digite o ângulo de rotação em graus:")
    angulo = IO.gets("") |> String.trim() |> String.to_integer()
    radianos = angulo * :math.pi() / 180.0

    nova_lista = Enum.map(lista, fn {x, y} ->
      novo_x = x * :math.cos(radianos) - y * :math.sin(radianos)
      novo_y = x * :math.sin(radianos) + y * :math.cos(radianos)
      {novo_x, novo_y}
    end)
    IO.puts("Rotação aplicada com sucesso.")
    nova_lista
  end

  def reflexao(lista) do
    IO.puts("Reflexão")
    IO.puts("Escolha o eixo de reflexão (x ou y):")
    eixo = IO.gets("") |> String.trim()

    nova_lista =
      case eixo do
        "x" -> Enum.map(lista, fn {x, y} -> {x, -y} end)
        "y" -> Enum.map(lista, fn {x, y} -> {-x, y} end)
        _ -> lista
      end

    IO.puts("Reflexão aplicada com sucesso.")
    nova_lista
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
      5. Translação
      6. Escala
      7. Rotação
      8. Reflexão
      9. Sair
      Entre com sua opção:
    """)

    case IO.gets("") |> String.trim() |> String.to_integer() do
      1 ->
        #IO.puts("Digite as coordenadas do ponto (x, y), separadas por espaço. Coloque um PAR de cada vez.")
        loop(criar(lista))

      2 ->
        listar(lista)
        loop(lista)

      3 ->
        loop(alterar(lista))

      4 ->
        loop(excluir(lista))

      5 ->
        loop(translacao(lista))

      6 ->
        loop(escala(lista))

      7 ->
        loop(rotacao(lista))

      8 ->
        loop(reflexao(lista))

      9 ->
        IO.puts("Até logo")

      _ ->
        IO.puts("Opção inválida")
        loop(lista)
    end
  end
end
