class Chisel

  # def parse(doc)
  #   # '<h1>'
  #   new = "#{doc}".gsub(/#/, '<h1>')
  #   new = "#{doc}".gsub(/$/, '</h1>')
  # end

  # class Paragraph
  #   def render
  #   end
  # end

end

class ChunkBuilder
  def parse(doc)
    arr = doc.split("\n\n")
    arr.map do |a|
      a.strip
    end
  end
end


class ChunkDetector
  def chunk_type(chunk)
    elements = chunk.match(/\A#+/).to_s
    if elements == '#'
      'h1'
    elsif elements == '##'
      'h2'
    elsif elements == '###'
      'h3'
    end

  end
end




# class H1
#   def render
#   end
# end

# # if <h1> then write </h1>
#
# '<1h/>'
# '</h1>'

# chunk builder = input.split
