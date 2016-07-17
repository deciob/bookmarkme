// https://scotch.io/tutorials/build-a-restful-api-using-node-and-express-4

var application_root = __dirname;
var bodyParser = require('body-parser');
var cheerio = require('cheerio');
var express = require('express');
var mongoose = require('mongoose');
var path = require('path');
var request = require('request');
var Xray = require('x-ray');

var connection_string = require('./connection-string');

var app = express();


// MODEL
mongoose.connect(connection_string);

var Bookmark = mongoose.model('Bookmark', new mongoose.Schema({
  name: String,
  url: String,
  tags: String
}));

var Tag = mongoose.model('Tag', new mongoose.Schema({
  name: String
}));


// SERVER

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());

var port = process.env.PORT || 8080;

var router = express.Router();

// middleware to use for all requests
router.use(function(req, res, next) {
  // do logging
  console.log('Something is happening.');
  next(); // make sure we go to the next routes and don't stop here
});

// test route to make sure everything is working
// (accessed at GET http://localhost:8080/api)
router.get('/', function(req, res) {
  res.json({
    message: 'api functioning!'
  });
});

function saveBookmark (req, res, title) {
  var bookmark = new Bookmark();
  bookmark.title = title;
  bookmark.url = req.body.url;
  bookmark.tags = req.body.tags;

  bookmark.save(function(err) {
    if (err) {
      res.send(err);
    }
    res.json({
      message: 'Bookmark created!'
    });
  });
}

router.route('/bookmarks')
  // create a bookmark (accessed at POST http://localhost:8080/api/bookmarks)
  .post(function(req, res) {
    var url = req.body.url;
    var title = req.body.title;
    if (title) {
      saveBookmark(req, res, title);
    } else {
      request(url, function(error, response, html){
        if (error) {
          res.send(err);
        }
        var $ = cheerio.load(html);
        title = $('title').text();
        saveBookmark(req, res, title);
      });
    }
  })
  // get all bookmarks
  .get(function(req, res) {
    Bookmark.find(function(err, bookmarks) {
      if (err) {
        res.send(err);
      }
      res.json(bookmarks);
    });
  });

router.route('/bookmarks/:id')
  // get bookmark by id
  .get(function(req, res) {
    Bookmark.findById(req.params.id, function(err, bookmark) {
      if (err) {
        res.send(err);
      }
      res.json(bookmark);
    });
  })
  // update by id (accessed at PUT http://localhost:8080/api/bookmarks/:id)
  .put(function(req, res) {
    // use our Bookmark model to find the bookmark we want
    Bookmark.findById(req.params.id, function(err, bookmark) {
      if (err) {
        res.send(err);
      }

      bookmark.title = req.body.title;
      bookmark.url = req.body.url;
      bookmark.tags = req.body.tags;

      // save the bear
      bookmark.save(function(err) {
        if (err) {
          res.send(err);
        }

        res.json({
          message: 'Bookmark updated!'
        });
      });
    });
  })
  // delete by id (accessed at DELETE http://localhost:8080/api/bookmarks/:id)
  .delete(function(req, res) {
    Bookmark.remove({
      _id: req.params.id
    }, function(err, bookmark) {
      if (err) {
        res.send(err);
      }

      res.json({ message: 'Successfully deleted' });
    });
  });

  router.route('/tags')
    // create a tag (accessed at POST http://localhost:8080/api/tags)
    .post(function(req, res) {
      var tag = new Tag();
      tag.name = req.body.name;

      // save the tag and check for errors
      tag.save(function(err) {
        if (err) {
          res.send(err);
        }
        res.json({
          message: 'Tag created!'
        });
      });
    })
    // get all tags
    .get(function(req, res) {
      Tag.find(function(err, tags) {
        if (err) {
          res.send(err);
        }
        res.json(tags);
      });
    });

  router.route('/tags/:id')
  // delete by id (accessed at DELETE http://localhost:8080/api/tags/:id)
    .delete(function(req, res) {
      Tag.remove({
        _id: req.params.id
      }, function(err, tag) {
        if (err) {
          res.send(err);
        }

        res.json({ message: 'Successfully deleted' });
      });
    });

// register the routes
app.use('/api', router);

// start the server
app.listen(port);
console.log('Magic happens on port ' + port);
