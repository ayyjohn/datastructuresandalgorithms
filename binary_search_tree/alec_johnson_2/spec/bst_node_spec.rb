require 'rspec'
require 'bst_node'

describe BSTNode do
  let(:bst_node) { BSTNode.new(5) }

  it "takes in a value in the constructor and defines it as an attr_reader" do
    expect(bst_node.value).to eq(5)
  end

  it "sets #left and #right as attr_accesors" do
    bst_node.left = BSTNode.new(2)
    expect(bst_node.left.value).to eq(2)

    bst_node.right = BSTNode.new(7)
    expect(bst_node.right.value).to eq(7)
  end

  it "sets #parent as an attr_accessor" do
    root_node = BSTNode.new(2)
    child_node = BSTNode.new(8)
    root_node.left = child_node
    child_node.parent = root_node

    expect(root_node.left.value).to eq(8)
    expect(child_node.parent.value).to eq(2)
  end
end
