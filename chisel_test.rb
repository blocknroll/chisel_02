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


  # HEADINGS ================================================
  def test_it_can_render_an_h1_heading
    h = Heading.new('# My Life in Desserts')
    assert_equal '<h1>My Life in Desserts</h1>', h.render(:h1)
  end

  def test_it_can_render_an_h2_heading
    h = Heading.new('## Chapter 1: The Beginning')
    assert_equal '<h2>Chapter 1: The Beginning</h2>', h.render(:h2)
  end

  def test_it_can_render_an_h3_heading
    h = Heading.new('### This is the h3 test')
    assert_equal '<h3>This is the h3 test</h3>', h.render(:h3)
  end

  def test_it_can_render_an_h4_heading
    h = Heading.new('#### This is the h4 test')
    assert_equal '<h4>This is the h4 test</h4>', h.render(:h4)
  end

  def test_it_can_render_an_h5_heading
    h = Heading.new('##### This is the h5 test')
    assert_equal '<h5>This is the h5 test</h5>', h.render(:h5)
  end

  def test_it_can_render_an_h6_heading
    h = Heading.new('###### This is the h6 test')
    assert_equal '<h6>This is the h6 test</h6>', h.render(:h6)
  end

end
