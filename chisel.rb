class Chisel
  def parse(doc)
    cb = ChunkBuilder.new
    chunks = cb.parse(doc)

    cd = ChunkDetector.new
    cd.chunk_type_for(chunks)

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
  def chunk_type_for(chunks)
    elements = chunks.match(/\A#+/).to_s
    if elements      == '#' then :h1 #heading.render(chunk)
      elsif elements == '##' then :h2
      elsif elements == '###' then :h3
      elsif elements == '####' then :h4
      elsif elements == '#####' then :h5
      elsif elements == '######' then :h6
      else :p
    end
  end
end


class Heading
  def initialize(chunk)
    @chunk = chunk
  end

  def render
    # remove markdown
      @chunk.slice!(/\A#+\s/)
    # string interpolation: put tags on both ends of the cleaned chunk
      # if :h1 then "<h1>#{@chunk}</h1>"
      "<h1>#{@chunk}</h1>"
  end
end



document = '# My Life in Desserts

## Chapter 1: The Beginning

"You just *have* to try the cheesecake," he said. "Ever since it appeared in
**Food & Wine** this place has been packed every night."'

cb = ChunkBuilder.new
output = cb.parse(document)
puts output
