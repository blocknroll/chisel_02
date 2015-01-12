require 'pry'

class Chisel
  def parse(doc)

    cb = ChunkBuilder.new
    chunks = cb.parse(doc)      # returns array of strings
    # binding.pry

    cd = ChunkDetector.new
    cd.chunk_type_for(chunks)   # returns :h1, :h2, etc.
    # binding.pry

    h = Heading.new(chunk)
    h.render(chunk)
  end
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
  def chunk_type_for(chunk)
    element = chunk.match(/\A#+/).to_s
    if element      == '#' then :h1 #heading.render(chunk)
      elsif element == '##' then :h2
      elsif element == '###' then :h3
      elsif element == '####' then :h4
      elsif element == '#####' then :h5
      elsif element == '######' then :h6
      else :p
    end
  end
end


class Heading
  def initialize(chunk)
    @chunk = chunk
  end

  def render(header_size)
    @chunk.slice!(/\A#+\s/)   # removes markdown
    if header_size == :h1 then "<h1>#{@chunk}</h1>"
      elsif header_size == :h2 then "<h2>#{@chunk}</h2>"
      elsif header_size == :h3 then "<h3>#{@chunk}</h3>"
      elsif header_size == :h4 then "<h4>#{@chunk}</h4>"
      elsif header_size == :h5 then "<h5>#{@chunk}</h5>"
      elsif header_size == :h6 then "<h6>#{@chunk}</h6>"
    end
  end
end



# document = '# My Life in Desserts
#
# ## Chapter 1: The Beginning
#
# "You just *have* to try the cheesecake," he said. "Ever since it appeared in
# **Food & Wine** this place has been packed every night."'
#
# cb = Chisel.new
# output = cb.parse(document)
# puts output
