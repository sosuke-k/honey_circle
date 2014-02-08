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
//= require bootstrap
//= require turbolinks
//= require_tree .

// var colors = ['#64B5C9','#64C9B3','#74BD88','#D7B047','#CF7F5B','#CE587F','#ad5fd8']
// var colors = ['#64C9B3','#74BD88','#D7B047','#CF7F5B','#CE587F','#ad5fd8']
var colors = ['#64C9B3','#74BD88','#D7B047','#CF7F5B']

$(window).load(function() {
	for (var i = 0; i < $('.timestamp').length; i++) {
		// $('.timestamp').eq(i).css({'background':colors[i % colors.length]})
		$('.timestamp').eq(i).css({'background':"#ccc"})
	}
  // setTimeout($('.alert').fadeOut(), 5000)
});