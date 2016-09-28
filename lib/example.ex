defmodule Elixir2pdf.Example do
  import Elixir2pdf

  @font1 {"OCR-B-Digits", 10}
  @font2 {"Times-Roman", 6}
  @font3 {"Courier-Bold", 12}
  @font4 {"Times-Roman", 5}
  @font5 {"OCR-A-Digits", 10}

  def check do
    pid = new

    pid
    |> draw_rectangle({85,675}, {300, 125}, 0.5)
    |> set_font(@font1, :blue)
    |> right_aligned_text(@font1, 375, 785, "1025")
    |> set_font(@font2)
    |> right_aligned_text(@font2, 300, 765, "DATE")
    |> draw_line({305, 765}, {355, 765}, 0.5)
    |> text(90,750, "PAY TO THE")
    |> text(90,745, "ORDER OF")
    |> draw_line({125, 745}, {315, 745}, 0.5)
    |> draw_line({315,745}, {315, 750}, 0.5)
    |> set_font(@font3)
    |> text(320, 745, "$")
    |> draw_rectangle({330, 742}, {45, 13}, 1, :antiquewhite4)
    |> draw_line({95, 727}, {320, 727}, 0.5)
    |> set_font(@font2)
    |> text(325, 727, "DOLLARS")
    |> set_font(@font4)
    |> text(90, 695, "MEMO")
    |> draw_line({110, 695}, {220, 695}, 0.5)
    |> draw_line({240, 695}, {375, 695}, 0.5)
    |> set_font(@font5)
    |> text(110, 680, "000000000  000000000    1025")

    |> export("./example.pdf")
    |> close
  end
end