describe "DOM#after" do
  before do
    @div = DOM.parse <<-HTML
      <div id="after-spec">
        <div id="some-header" class="kapow"></div>
        <div id="foo" class="after-spec-first"></div>
        <div id="bar" class="after-spec-first"></div>
        <div id="baz"></div>
      </div>
    HTML

    @div.append_to_body
  end

  after do
    @div.remove
  end

  it "should insert the given html string after each element" do
    el = DOM.find '.after-spec-first'
    el.size.should == 2

    el.after '<p class="woosh"></p>'

    DOM.id('foo').next.class_name.should == "woosh"
    DOM.id('bar').next.class_name.should == "woosh"
  end

  it "should insert the given DOM element after this element" do
    DOM.id('baz').after DOM.id('some-header')
    DOM.id('baz').next.id.should == "some-header"
  end
end