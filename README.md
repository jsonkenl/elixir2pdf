# Elixir2pdf

Elixir2pdf is a simple Elixir wrapper for ErlGuten, a Erlang PDF generation application. It is limited to my current needs of ErlGuten's functionality as well as some additional functionality not provided by ErlGuten, but I will continue to explore ErlGuten and improve Elixir2pdf over time. If you require specific functionality of ErlGuten that is not currently exposed, please submit an [issue](https://github.com/kennellroxco/elixir2pdf/issues). 

## Installation

The package can be installed via GitHub:

    def deps do
      [{:elixir2pdf, github: "kennellroxco/elixir2pdf"}]
    end

## Basic Usage

PDF files have the following basic properties: 
- The origin `{0, 0}` of a given document is the bottom-left corner. The x-axis extends to the right and the y-axis extends upward.
- Locations and sizes are stored as a `PDF unit`. Each `PDF unit` is equal to 1/72 of an inch. For example, the coordinate point `{72, 72}` is located 1 inch to the right of the left edge of the page and 1 inch above the bottom edge of the page.
- PDF documents are sized according to their `media box` and `crop box` values. The `media box` is the total size of the document while the `crop box` is the viewable area. While most PDF documents have the same `media box` and `crop box` values, this is important to note because the origin `{0, 0}` is in relation to the `media box` as opposed to the viewable area of the `crop box`.

### Current Exposed Functions: 

  General
  - [new/1](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L10)
  - [close/1](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L191)

  Document
  - [set_new_page/1](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L22)
  - [export/2](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L179)

  Text
  - [set_font/3](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L38)
  - [text/4](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L55)
  - [right_aligned_text/5](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L74)
  - [center_aligned_text/6](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L100)

  Graphics
  - [draw_line/5](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L131)
  - [draw_rectangle/5](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L150)
  - [insert_image/4](https://github.com/kennellroxco/elixir2pdf/blob/master/lib/elixir2pdf.ex#L167)

### Example:

```elixir
defmodule Example do
  import Elixir2pdf

  @font1 {"OCR-B-Digits", 10}
  @font2 {"Times-Roman", 6}
  @font3 {"Courier-Bold", 12}
  @font4 {"Times-Roman", 5}
  @font5 {"OCR-A-Digits", 10}

  def check_template do
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
```

## Contributing 

Contributions are encouraged. Feel free to fork the repo, add your code along with appropriate tests and documentation (ensuring all existing tests continue to pass) and submit a pull request.


