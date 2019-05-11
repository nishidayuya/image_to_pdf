require "pdf/core/page_geometry"

require "image_to_pdf"

module ImageToPdf::PaperSizeParser
  extend self

  AVAILABLE_DIRECTIONS = %i[landscape portrait]

  # @param [String] s paper size text. "a4-landscape", "b3-portrait", etc.
  # @return [ImageToPdf::Dimension] parsed paper dimension. points.
  def call(s)
    paper_size, direction = *s.split("-")
    direction = direction.downcase.to_sym
    if !AVAILABLE_DIRECTIONS.include?(direction)
      raise ImageToPdf::ParserError, "invalid paper direction: #{s.inspect}"
    end
    raw_size_pt = PDF::Core::PageGeometry::SIZES[paper_size.upcase]
    if !raw_size_pt
      raise ImageToPdf::ParserError, "invalid paper size: #{s.inspect}"
    end

    paper_dimension_pt = ImageToPdf::Dimension.from_array(raw_size_pt)
    paper_dimension_pt = paper_dimension_pt.justify_direction(direction)

    return paper_dimension_pt
  end
end
