function drawGraph(elements) {
  cytoscape({
    container: document.getElementById('cy'),

    autounselectify: true,
    boxSelectionEnabled: false,

    // fit: false,
    // zoom: 5,
    wheelSensitivity: 0.1,

    style: cytoscape.stylesheet()
      .selector('node')
      .css({
        'content': 'data(name)',
        'font-family': 'helvetica, monospace',
        'text-valign': 'center',
        'color': 'white',
        'text-outline-width': 1,
        'text-outline-color': '#888',
        'shape': 'roundrectangle',
        'width': '200px',
        // 'width': 'mapData(weight, 40, 80, 20, 60)',
        // 'width': '100%',
        // 'height': '100%'
      })
      .selector('.interproceduralEdge')
      .css({
        'curve-style': 'bezier',
        'width': 8,
        'target-arrow-shape': 'triangle',
        'line-color': '#9dbaea',
        'target-arrow-color': '#9dbaea'
      })
      .selector('.intraproceduralEdge')
      .css({
        'curve-style': 'bezier',
        'width': 5,
        'target-arrow-shape': 'triangle',
        'line-color': '#ff0000',
        'target-arrow-color': '#ff0000'
      })
      .selector('$node > node')
      .css({
        'shape': 'roundrectangle',
        'text-valign': 'top',
        'background-color': '#ccc',
        'background-opacity': 0.333,
        'color': '#000',
        'text-outline-width': 0,
        'font-size': 25,
        'text-outline-width': 1,
        'text-outline-color': '#fff',
      })
      .selector('#method, .method')
      .css({
        'background-color': '#93CDDD',
        'line-color': '#93CDDD',
        'target-arrow-color': '#93CDDD'
      }),

    elements: elements,

    layout: {
      name: 'dagre',
      fit: true,
      padding: -400,
    }
  });
}
