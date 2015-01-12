gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './chisel'

class ChiselTest < Minitest::Test

  def test_it_exists
    parser = Chisel.new
    assert parser
  end

  def test_chunk_builder_can_parse
    doc = '# My Life in Desserts

    ## Chapter 1: The Beginning

    "You just *have* to try the cheesecake," he said. "Ever since it appeared in
    **Food & Wine** this place has been packed every night."'
    cb = ChunkBuilder.new
    chunks = cb.parse(doc)
    assert_equal '# My Life in Desserts', chunks[0]
    assert_equal '## Chapter 1: The Beginning', chunks[1]
    assert_equal '"You just *have* to try the cheesecake," he said. "Ever since it appeared in
    **Food & Wine** this place has been packed every night."', chunks[2]
  end

  def test_it_can_detect_chunks
    cd = ChunkDetector.new
    assert_equal :h1, cd.chunk_type_for('# My Life in Desserts')
    assert_equal :h2, cd.chunk_type_for('## Chapter 1: The Beginning')
    assert_equal :h3, cd.chunk_type_for('### This is the h3 test')
    assert_equal :h4, cd.chunk_type_for('#### This is the h4 test')
    assert_equal :h5, cd.chunk_type_for('##### This is the h5 test')
    assert_equal :h6, cd.chunk_type_for('###### This is the h6 test')
    assert_equal :p, cd.chunk_type_for('"You just *have* to try the cheesecake," he said. "Ever since it appeared in
    **Food & Wine** this place has been packed every night."')
  end

  def test_it_can_render_an_h1_heading
    h = Heading.new('# My Life in Desserts')
    assert_equal '<h1>My Life in Desserts</h1>', h.render
  end

  # def test_it_can_render_an_h2_heading
  #   h = Heading.new('## Chapter 1: The Beginning')
  #   assert_equal '<h2>Chapter 1: The Beginning</h2>', h.render
  # end

end









  # def test_h1
  #   parser = Chisel.new
  #   a_string = "# My Life in Desserts"
  #   result = parser.parse(a_string)
  #   assert_equal '<h1> My Life in Desserts', result
  # end
  #
  # def test_h1_close
  #   parser = Chisel.new
  #   a_string = "# My Life in Desserts"
  #   result = parser.parse(a_string)
  #   assert_equal '<h1> My Life in Desserts</h1>', result
  # end


  # def test_h2
  #   parser = Chisel.new
  #   a_string = "## My Life in Desserts"
  #   result = parser.parse(a_string)
  #   assert_equal '<h2> My Life in Desserts', result
  # end
