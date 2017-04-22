defmodule Elixir2pdf do
  @moduledoc """
  Elixir2pdf is a simple Elixir wrapper for ErlGuten, a Erlang PDF generation application.
  See README.md for a general overview.
  """

  @doc """
  Starts a new PDF process and returns a process identifier (pid).
  """
  def new do
    :eg_pdf.new
  end

  @doc """
  Creates a new page and returns a process identifier (pid). Any subsequent activity will occur
  on the new page. Note: Elixir2pdf.new/0 takes care of this, so it is not necessary for the
  first page.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  """
  def set_new_page(pid) do
    page_no = pid |> :eg_pdf.new_page
    pid |> :eg_pdf.set_page(page_no)
    pid
  end

  @doc """
  Set the PDF page size to a predefined preset size, for example `:a4`.
  A number of common papersizes are supported. A complete enumeration of predefined sizes
  can be checked [here](https://github.com/kennellroxco/erlguten/blob/master/src/eg_pdf.erl#L210).

  ## Parameters
  - `pagesize` - Predefined page size atom.
  """
  def set_pagesize(pid, pagesize) do
    pid |> :eg_pdf.set_pagesize(pagesize)
    pid
  end

  @doc """
  Set the PDF page size to the specified width and height

  ## Parameters
  - `width` - Page width
  - `height` - Page height
  """
  def set_pagesize(pid, width, height) do
    pid |> :eg_pdf.set_pagesize(width, height)
    pid
  end

  @doc """
  Sets the font that will apply to all text that follows.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `font` - a tuple containing the name of the font in `string` format and the font size in `integer` format. See
  the FONTS.md documentation for a list of available fonts.
  - `color` - name of font color in `atom` format. See the COLORS.md documentation for a list of
  available colors. Default is `:black`.
  """
  def set_font(pid, font, color \\ :black) do
    {name, size} = font
    pid |> :eg_pdf.set_fill_color(color)
    pid |> :eg_pdf.set_font(name |> String.to_charlist, size)
    pid
  end

  @doc """
  Adds text to a PDF process at a given coordinate. See the README.md file for
  additional detail on how PDF document navigation works.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `x` - the horizontal coordinate point in `integer` format.
  - `y` - the vertical coordinate point in `integer` format.
  - `text` - the actual text to be added in `string` format.
  """
  def text(pid, x, y, text) do
    pid |> :eg_pdf.begin_text
    pid |> :eg_pdf.set_text_pos(x, y)
    pid |> :eg_pdf.text(text |> String.to_charlist)
    pid |> :eg_pdf.end_text
    pid
  end

  @doc """
  Adds text to a PDF process at a given coordinate with right-hand justification.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `set_font` - a tuple containing the name and font size of the current font set
  (i.e. {"Helvetica", 8}).
  - `x` - the horizontal coordinate point where the text will end in `integer` format.
  - `y` - the vertical coordinate point in `integer` format.
  - `text` - the actual text to be added in `string` format.
  """
  def right_aligned_text(pid, set_font, x, y, text) do
    {name, size} = set_font
    text   = text |> String.to_charlist
    name   = name |> String.to_charlist
    length = pid  |> :eg_pdf.get_string_width(name, size, text)
    x      = x - length

    pid |> :eg_pdf.begin_text
    pid |> :eg_pdf.set_text_pos(x, y)
    pid |> :eg_pdf.text(text)
    pid |> :eg_pdf.end_text
    pid
  end

  @doc """
  Adds text to a PDF process that is centered between the two horizontal coordinate points given.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `x1` - the starting horizontal coordinate point in `integer` format.
  - `x2` - the ending horizontal coordinate point in `integer` format.
  - `y` - the vertical coordinate point in `integer` format.
  - `set_font` - a tuple containing the name and font size of the current font set
  (i.e. {"Helvetica", 8}).
  - `text` - the actual text to be added in `string` format.
  """
  def center_aligned_text(pid, x1, x2, y, set_font, text) do
    {name, size} = set_font
    text   = text |> String.to_charlist
    name   = name |> String.to_charlist
    length = pid  |> :eg_pdf.get_string_width(name, size, text)
    start  = (x2 - x1)
             |> Kernel.-(length)
             |> Kernel./(2)
             |> Kernel.+(x1)
             |> round

    pid |> :eg_pdf.begin_text
    pid |> :eg_pdf.set_text_pos(start, y)
    pid |> :eg_pdf.text(text)
    pid |> :eg_pdf.end_text
    pid
  end

  @doc """
  Draws a line between the two coordinate points given.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `from` - a tuple containing the `x` and `y` coordinate points of the start of a
  line (i.e. {0, 0}).
  - `to` - a tuple containing the `x` and `y` coordinate points of the end of a
  line (i.e. {72, 72}).
  - `width` - the desired thickness of the line in `integer` or `float` format.
  - `color` - name of line color in `atom` format. See the COLORS.md documentation for a list of
  available colors. Default is `:black`.
  """
  def draw_line(pid, from, to, width, color \\ :black) do
    pid |> :eg_pdf.set_stroke_color(color)
    pid |> :eg_pdf.set_line_width(width)
    pid |> :eg_pdf.line(from, to)
    pid
  end

  @doc """
  Draws a rectangle starting at a given basepoint of a given size.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `basepoint` - a tuple containing the coordinate points where the bottom-left corder of the rectangle
  will be located (i.e. {0, 0}).
  - `size` - a tuple containing the width and height dimensions of the image (i.e. {64, 89}).
  - `width` - the desired thickness of the line in `integer` or `float` format.
  - `color` - name of line color in `atom` format. See the COLORS.md documentation for a list of
  available colors. Default is `:black`.
  """
  def draw_rectangle(pid, basepoint, size, width, color \\ :black) do
    pid |> :eg_pdf.set_stroke_color(color)
    pid |> :eg_pdf.set_line_width(width)
    pid |> :eg_pdf.rectangle(basepoint, size, :stroke)
    pid
  end

  @doc """
  Inserts an image into the PDF from a given path.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `path` - path where the image file is located in `string` format (i.e. "./example.jpg").
  - `basepoint` - a tuple containing the coordinate points where the bottom-left corder of the image
  will be located (i.e. {0, 0}).
  - `size` - a tuple containing the width and height dimensions of the image (i.e. {64, 89}).
  """
  def insert_image(pid, path, basepoint, size) do
    pid |> :eg_pdf.image(path |> String.to_charlist, basepoint, size)
    pid
  end

  @doc """
  Exports the PDF process to a PDF file at the given path.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  - `path` - path where the generated PDF file will be saved in `string` format (i.e. "./example.pdf").
  """
  def export(pid, path) do
    {pdf, _} = pid |> :eg_pdf.export
    File.write("#{path}", pdf)
    pid
  end

  @doc """
  Deletes the PDF process at the given identifier.

  ## Parameters
  - `pid` - the process identifier of the current PDF process.
  """
  def close(pid) do
    pid |> :eg_pdf.delete
  end
end
