function drawGraph(elements) {
  cytoscape({
    container: document.getElementById('cy'),

    autounselectify: true,
    boxSelectionEnabled: false,

    style: [
      {
        selector: 'node',
        style: {
          'content': 'data(id)',
          'text-opacity': 1,
          'text-valign': 'center',
          'text-halign': 'center',
          'color': '#ffffff',
          'background-color': '#11479e',
          'shape': 'roundrectangle',
        }
      },

      {
        selector: 'edge',
        style: {
          'curve-style': 'bezier',
          'width': 4,
          'target-arrow-shape': 'triangle',
          'line-color': '#9dbaea',
          'target-arrow-color': '#9dbaea'
        }
      }
      // {
      //   css: {
      //     'content': 'data(id)',
      //     'text-valign': 'center',
      //     'text-halign': 'center'
      //   },
      //   selector: 'node',
      // },
      // {
      //   css: {
      //     'padding-top': '10px',
      //     'padding-left': '10px',
      //     'padding-bottom': '10px',
      //     'padding-right': '10px',
      //     'text-valign': 'top',
      //     'text-halign': 'center',
      //     'background-color': '#bbb'
      //   },
      //   selector: '$node > node',
      // },
      // {
      //   css: {
      //     'target-arrow-shape': 'triangle'
      //   },
      //   selector: 'edge',
      // },
      // {
      //   css: {
      //     'background-color': 'black',
      //     'line-color': 'black',
      //     'target-arrow-color': 'black',
      //     'source-arrow-color': 'black',
      //   },
      //   selector: ':selected',
      // }
    ],

    elements: elements,

    layout: {
      name: 'dagre',
      // name: 'preset',
      // padding: 5
    }
  });
}
