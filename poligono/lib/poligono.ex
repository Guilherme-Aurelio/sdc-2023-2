defmodule Poligono do
  @pontos []

  def principal() do
    loop()
  end

  def criar() do
   IO.puts("Digite as coordenadas do ponto (x,y):")
  input = String.trim(IO.gets(""))

  case String.split(input, ~r{,}) do
    [x, y] ->
      ponto = {x, y}
      [ponto]
    _ ->
      IO.puts("Formato de coordenadas inválido. Use o formato x,y.")
  end
    loop()
  end

  def listar() do
    IO.puts("Pontos do polígono:")
    Enum.each(@pontos, fn ponto -> IO.puts("#{elem(ponto, 0)}, #{elem(ponto, 1)}") end)
    loop()
  end

  def atualizar() do
    IO.puts("Digite o índice do ponto a ser atualizado:")
    index = String.to_integer(IO.gets(""))
    IO.puts("Digite as novas coordenadas do ponto (x,y):")
    coords = String.split(IO.gets(""), ~r{,})
    ponto = {String.trim(Enum.at(coords, 0)), String.trim(Enum.at(coords, 1))}
    {:ok, _} = atualizar_ponto(index, ponto)
    IO.puts("Ponto atualizado com sucesso!")
    loop()
  end

  def excluir() do
    IO.puts("Digite o índice do ponto a ser excluído:")
    index = String.to_integer(IO.gets(""))
    {:ok, _} = excluir_ponto(index)
    IO.puts("Ponto excluído com sucesso!")
    loop()
  end

  def sair() do
    IO.puts("Saindo do sistema...")
    :ok
  end

  defp adicionar_ponto(ponto) do
    @pontos ++ [ponto]
  end

  defp atualizar_ponto(index, ponto) do
    pontos_atualizados = Enum.with_index(@pontos, fn {p, i} -> if i == index, do: ponto, else: p end)
    {:ok, @pontos = pontos_atualizados}
  end

  defp excluir_ponto(index) do
    pontos_atualizados = Enum.delete_at(@pontos, index)
    {:ok, @pontos = pontos_atualizados}
  end

  def translatar() do
    listar()
    if Enum.empty?(@pontos) do
      IO.puts("Não há pontos para realizar a translação.")
    else
      IO.puts("Digite o valor de deslocamento em X: ")
      deslocamento_x = String.to_float(IO.gets!(""))

      IO.puts("Digite o valor de deslocamento em Y: ")
      deslocamento_y = String.to_float(IO.gets!(""))

      @pontos = Enum.map(@pontos, fn {x, y} -> {x + deslocamento_x, y + deslocamento_y} end)
      IO.puts("Translação realizada com sucesso.")
    end
  end

  def zoom() do
    listar()
    if Enum.empty?(@pontos) do
      IO.puts("Não há pontos para realizar o zoom.")
    else
      IO.puts("Digite o valor de escala em X: ")
      escala_x = String.to_float(IO.gets!(""))

      IO.puts("Digite o valor de escala em Y: ")
      escala_y = String.to_float(IO.gets!(""))

      @pontos = Enum.map(@pontos, fn {x, y} -> {x * escala_x, y * escala_y} end)
      IO.puts("Zoom realizado com sucesso.")
    end
  end

  def rotacionar() do
    listar()
    if Enum.empty?(@pontos) do
      IO.puts("Não há pontos para realizar a rotação.")
    else
      IO.puts("Digite o ângulo de rotação (em graus): ")
      angulo = String.to_float(IO.gets!(""))

      radianos = :math.pi * angulo / 180.0

      @pontos = Enum.map(@pontos, fn {x, y} ->
        novo_x = x * :math.cos(radianos) - y * :math.sin(radianos)
        novo_y = x * :math.sin(radianos) + y * :math.cos(radianos)
        {novo_x, novo_y}
      end)

      IO.puts("Rotação realizada com sucesso.")
    end
  end

  def refletir() do
    listar()
    if Enum.empty?(@pontos) do
      IO.puts("Não há pontos para realizar a reflexão.")
    else
      IO.puts("Escolha o eixo de reflexão:")
      IO.puts("1. Eixo X")
      IO.puts("2. Eixo Y")
      opcao = String.to_integer(IO.gets!(""))

      case opcao do
        1 ->
          @pontos = Enum.map(@pontos, fn {x, y} -> {x, -y} end)
          IO.puts("Reflexão em relação ao eixo X realizada com sucesso.")
        2 ->
          @pontos = Enum.map(@pontos, fn {x, y} -> {-x, y} end)
          IO.puts("Reflexão em relação ao eixo Y realizada com sucesso.")
        _ ->
          IO.puts("Opção inválida.")
      end
    end
  end

  def loop() do
    IO.puts("\nSistema Final")
    IO.puts("=============\n")
    IO.puts("1. Criar")
    IO.puts("2. Listar")
    IO.puts("3. Atualizar")
    IO.puts("4. Excluir")
    IO.puts("5. Translatar")
    IO.puts("6. Zoom")
    IO.puts("7. Rotacionar")
    IO.puts("8. Refletir")
    IO.puts("9. Sair")

    IO.puts("\nEntre com sua opção: ")
    opcao = String.to_integer(IO.gets("") |> String.trim)
    case opcao do
      1 -> criar()
      2 -> listar()
      3 -> atualizar()
      4 -> excluir()
      5 -> translatar()
      6 -> zoom()
      7 -> rotacionar()
      8 -> refletir()
      9 -> sair()
      _ ->
        IO.puts("Opção inválida. Tente novamente.")
        loop()
    end

    loop()
  end

end
