var $ = require('jquery');
var styles = require('./index.css');

$(setup);

function setup() {
  var $container = $('.article-feedback-container');
  $container.html(`
    <div class=${styles.rating}>
      <span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span>
    </div>
  `);
  $container.on('click', function(e) {
    var rating = 5 - $(e.target).index();
    $.ajax({
      url: 'http://localhost:3000/ratings?rating=' + rating,
      type: 'get',
      dataType: 'jsonp',
      error: function() {},
    });
  });
}
