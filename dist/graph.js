function drawGraph(elements) {
  cytoscape({
    container: document.getElementById('cy'),

    autounselectify: true,
    boxSelectionEnabled: false,

    style: cytoscape.stylesheet()
    .selector('node')
      .css({
        'content': 'data(name)',
        'text-valign': 'center',
        'color': 'white',
        'text-outline-width': 5,
        'text-outline-color': '#888',
        'width': 80,
        'height': 80
      })
    .selector('edge')
      .css({
        'content': 'data(name)',
        'width': 8,
        'line-color': '#888',
        'target-arrow-color': '#888',
        'source-arrow-color': '#888',
        'target-arrow-shape': 'triangle'
      })
    .selector(':selected')
//       .css({
//         'background-color': 'black',
//         'line-color': 'black',
//         'target-arrow-color': 'black',
//         'source-arrow-color': 'black',
//         'text-outline-color': 'black'
//       })
    .selector('$node > node')
      .css({
        'shape': 'roundrectangle',
        'text-valign': 'top',
        'height': 'auto',
        'width': 'auto',
        'background-color': '#ccc',
        'background-opacity': 0.333,
        'color': '#888',
        'text-outline-width':
        0,
        'font-size': 25
      })
    // .selector('#core, #app')
    //   .css({
    //     'width': 120,
    //     'height': 120,
    //     'font-size': 25
    //   })
    // .selector('#api')
    //   .css({
    //     'padding-top': 20,
    //     'padding-left': 20,
    //     'padding-bottom': 20,
    //     'padding-right': 20
    //   })
    .selector('#method, .method')
      .css({
        'background-color': '#93CDDD',
        'text-outline-color': '#93CDDD',
        'line-color': '#93CDDD',
        'target-arrow-color': '#93CDDD'
      })
    // .selector('#app, .app')
    //   .css({
    //     'background-color': '#F79646',
    //     'text-outline-color': '#F79646',
    //     'line-color': '#F79646',
    //     'target-arrow-color': '#F79646',
    //     'text-outline-color': '#F79646',
    //     'text-outline-width': 5,
    //     'color': '#fff'
    //   })
    // .selector('#cy')
    //   .css({
    //     'background-opacity': 0,
    //     'border-width': 1,
    //     'border-color': '#aaa',
    //     'border-opacity': 0.5,
    //     'font-size': 50,
    //     'padding-top': 40,
    //     'padding-left': 40,
    //     'padding-bottom': 40,
    //     'padding-right': 40
    //   })
      ,



    // style: [
    //   {
    //     selector: 'node',
    //     style: {
    //       'content': 'data(name)',
    //       'text-opacity': 1,
    //       'text-valign': 'center',
    //       'text-halign': 'center',
    //       'color': '#000000',
    //       'background-color': '#11479e',
    //       'shape': 'roundrectangle',
    //     }
    //   },

    //   {
    //     selector: 'edge',
    //     style: {
    //       'curve-style': 'bezier',
    //       'width': 4,
    //       'target-arrow-shape': 'triangle',
    //       'line-color': '#9dbaea',
    //       'target-arrow-color': '#9dbaea'
    //     }
    //   }

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
    // ],

    elements: elements,

    layout: {
      // name: 'dagre',
      name: 'preset',
      padding: 5
    }
  });
}
