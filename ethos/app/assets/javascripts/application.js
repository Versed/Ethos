// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .
//= require js-routes
'use strict';

$(function(){ $(document).foundation(); });

window.loadedActivities = [];

var addActivity = function(item) {
  var found = false;

  var length = window.loadedActivities.length;
  for (var i = 0; i < length; i++) {
    if (window.loadedActivities[i].id === item.id) {
      found = true;
    }
  }

  if (!found) {
    window.loadedActivities.push(item);
  }

  return item;
};

var renderActivities = function() {
  var source = $('#activities-template').html();
  var template = Handlebars.compile(source);
  var html = template({activities: window.loadedActivities});
  var activityFeed = $('#activity-feed');
  activityFeed.empty();
  activityFeed.addClass('has-dropdown');
  activityFeed.html(html);
};

var pollActivity = function() {
  $.ajax({
    url: Routes.activites_path({format: 'json', since: window.lastFetch}),
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      window.lastFetch = Math.floor((new Date).getTime() / 1000);
      if (data.length === 0) { return; }

      var length = data.length;
      for (var i = 0; i < length; i++) {
        addActivity(data[i]);
      }

      renderActivities();
    }
  });
};

window.pollInterval = window.setInterval(pollActivity, 5000);
