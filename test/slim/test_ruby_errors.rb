require 'helper'

class TestSlimRubyErrors < TestSlim
  def test_broken_output_line
    source = %q{
p = hello_world + \
  hello_world + \
  unknown_ruby_method
}

    assert_ruby_error NameError, "(__TEMPLATE__):4", source
  end

  def test_broken_output_line2
    source = %q{
p = hello_world + \
  hello_world
p Hello
= unknown_ruby_method
}

    assert_ruby_error NameError,"(__TEMPLATE__):5", source
  end

  def test_output_block
    source = %q{
p = hello_world "Hello Ruby" do
  = unknown_ruby_method
}

    assert_ruby_error NameError,"(__TEMPLATE__):3", source
  end

  def test_output_block2
    source = %q{
p = hello_world "Hello Ruby" do
  = "Hello from block"
p Hello
= unknown_ruby_method
}

    assert_ruby_error NameError, "(__TEMPLATE__):5", source
  end

  def test_text_block
    source = %q{
p Text line 1
  Text line 2
= unknown_ruby_method
}

    assert_ruby_error NameError,"(__TEMPLATE__):4", source
  end

  def test_invalid_nested_code
    source = %q{
p
  - test = 123
    = "Hello from within a block! "
}
    assert_ruby_syntax_error "(__TEMPLATE__):5", source
  end

  def test_invalid_nested_output
    source = %q{
p
  = "Hello Ruby!"
    = "Hello from within a block! "
}
    assert_ruby_syntax_error "(__TEMPLATE__):5", source
  end
end