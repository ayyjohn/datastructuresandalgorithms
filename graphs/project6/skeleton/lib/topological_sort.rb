require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_degree.zero?
  end
  until queue.empty?
    current = queue.shift
    p current.out_edges.map { |el| el.to_vertex.in_degree }
    sorted << current.value
    current.out_edges.each do |edge|
      queue.push(edge.to_vertex) if edge.to_vertex.in_degree - 1 <= 0
      edge.destroy!
    end
  end
  return sorted
end
